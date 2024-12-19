<?php

namespace app\controllers;

use app\models\AccessStatus;
use app\models\Course;
use app\models\CourseAccess;
use app\models\Level;
use app\models\Role;
use app\models\User;
use Yii;
use yii\filters\auth\HttpBearerAuth;
use yii\rest\Controller;
use yii\web\UploadedFile;

class UserController extends Controller
{
    public $modelClass = 'app\models\User';

    public function behaviors()
    {
        $behaviors = parent::behaviors();
        $behaviors['authenticator'] = [
            'class' => HttpBearerAuth::class,
            'only' => ['delete']
        ];
        return $behaviors;
    }


    public function actions()
    {
        $actions = parent::actions();
        unset($actions['create']);
        return $actions;
    }

    public function actionCreate()
    {
        $data = Yii::$app->request->post();
        $user = new User();
        $user->load($data, '');

        if (!$user->validate()) {
            $response = $this->response;
            $response->statusCode = 422;
            $response->data['code'] = 422;
            $response->data['message'] = "Validation error";
            $response->data['errors'] = $user->errors;
            return $response;
        }

        if (User::find()->where(['email' => $user->email])->one()) {
            $response = $this->response;
            header('Access-Control-Allow-Origin: *');
            $response->statusCode = 409;
            $response->data['code'] = 409;
            $response->data['message'] = "The user already exists";
            return $response;
        } else {
            $user->password = Yii::$app->getSecurity()->generatePasswordHash($user->password);
            $token = Yii::$app->getSecurity()->generateRandomString();
            $user->token = $token;
            $user->save();

            $response = $this->response;
            header('Access-Control-Allow-Origin: *');
            $response->statusCode = 201;
            $response->data['token'] = $token;
            return $response;
        }
    }

    public function actionLogin()
    {
        $data = Yii::$app->request->post();

        if (empty($data['email']) && empty($data['password'])) {
            $response = $this->response;
            $response->data = [
                'code' => 422,
                'message' => 'Validation error',
                'errors' => [
                    'email' => 'The email should not be empty',
                    'password' => 'The password should not be empty'
                ]
            ];
            $response->statusCode = 422;
            return $response;
        }

        if (empty($data['email'])) {
            $response = $this->response;
            $response->data = [
                'code' => 422,
                'message' => 'Validation error',
                'errors' => [
                    'email' => 'The email should not be empty'
                ]
            ];
            $response->statusCode = 422;
            return $response;
        }

        if (empty($data['password'])) {
            $response = $this->response;
            $response->data = [
                'code' => 422,
                'message' => 'Validation error',
                'errors' => [
                    'password' => 'The password should not be empty'
                ]
            ];
            $response->statusCode = 422;
            return $response;
        }

        $user = User::find()->where(['email' => $data['email']])->one();

        if (!$user) {
            $response = $this->response;
            $response->data = [
                'code' => 404,
                'message' => 'Unauthorized',
                'errors' => [
                    'error' => 'The user does not exist'
                ]
            ];
            $response->statusCode = 404;
            return $response;
        } else {
            if (Yii::$app->getSecurity()->validatePassword($data['password'], $user->password)) {
                $token = Yii::$app->getSecurity()->generateRandomString();
                $user->token = $token;
                $user->save(false);

                $response = $this->response;
                header('Access-Control-Allow-Origin: *');
                $response->statusCode = 201;
                $response->data['token'] = $token;
                return $response;
            } else {
                $response = $this->response;
                $response->data = [
                    'code' => 401,
                    'message' => 'Unauthorized',
                    'errors' => [
                        'error' => 'The email or password incorrect'
                    ]
                ];
                $response->statusCode = 401;
                return $response;
            }
        }
    }

    public function actionChangePhone()
    {
        $data = Yii::$app->request->getBodyParams();
        $token = User::getToken();
        $user = User::findByToken($token);

        if (!$user) {
            $response = $this->response;
            $response->data = [
                'code' => 401,
                'message' => 'Unauthorized'
            ];
            $response->statusCode = 401;
            return $response;
        }

        if (empty($data['phone'])) {
            $response = $this->response;
            $response->data = [
                'code' => 422,
                'message' => 'Validation error',
                'errors' => [
                    'phone' => 'The phone should not be empty'
                ]
            ];
            $response->statusCode = 422;
            return $response;
        } else {
            $user->phone = $data['phone'];
            $user->save();

            $response = $this->response;
            $response->data = [
                'status' => true,
            ];
            $response->statusCode = 200;
            return $response;
        }
    }

    public function actionChangeEmail()
    {
        $data = Yii::$app->request->getBodyParams();
        $token = User::getToken();
        $user = User::findByToken($token);

        if (!$user) {
            $response = $this->response;
            $response->data = [
                'code' => 401,
                'message' => 'Unauthorized'
            ];
            $response->statusCode = 401;
            return $response;
        }

        if (empty($data['email'])) {
            $response = $this->response;
            $response->data = [
                'code' => 422,
                'message' => 'Validation error',
                'errors' => [
                    'email' => 'The email should not be empty'
                ]
            ];
            $response->statusCode = 422;
            return $response;
        } else {
            $user->email = $data['email'];
            $user->save();

            $response = $this->response;
            $response->data = [
                'status' => true,
            ];
            $response->statusCode = 200;
            return $response;
        }
    }

    public function actionData()
    {
        $token = User::getToken();
        $user = User::findByToken($token);

        if (!$user) {
            $response = $this->response;
            $response->data = [
                'code' => 401,
                'message' => 'Unauthorized'
            ];
            $response->statusCode = 401;
            return $response;
        }

        $courses = [];
        $course_accesses = CourseAccess::find()->where(["student" => $user->id_user])->all();

        for ($index = 0; $index < count($course_accesses); $index++) {
            $course_item = [
                'course_id' => $course_accesses[$index]['course_id'],
                'name' => Course::find()->where(['id_course' => $course_accesses[$index]['course_id']])->one()->course_name,
                'status_name' => AccessStatus::find()->where(['id_access_status' => $course_accesses[$index]['status_id']])->one()->status_name,
            ];
            array_push($courses, $course_item);
        }

        $response = $this->response;
        $response->data = [
            "id_user" => $user->id_user,
            "first_name" => $user->first_name,
            "last_name" => $user->last_name,
            "middle_name" => $user->middle_name,
            "phone" => $user->phone,
            "email" => $user->email,
            "level" => Level::find()->where(['id_level' => $user->level_id])->select(['level_code', 'level_title', 'level_name'])->one(),
            "role_name" => Role::find()->where(['id_role' => $user->role_id])->one()->role_name,
            "check_email" => $user->check_email,
            "courses" => $courses
        ];
        $response->statusCode = 200;
        return $response;
    }

    public function actionPhoto()
    {
        $token = User::getToken();
        $user = User::findByToken($token);

        if (!$user) {
            $response = $this->response;
            $response->data = [
                'code' => 401,
                'message' => 'Unauthorized'
            ];
            $response->statusCode = 401;
            return $response;
        }

        $photo = UploadedFile::getInstance($user, 'photo');

        if (!is_null($photo)) {
            $path = Yii::$app->basePath . '/assets/uploads/' . hash('sha256', $photo->baseName) . '.' . $photo->extension;
            $photo->saveAs($path);
            $user->photo = $path;
            $user->save();
        }
    }
}
