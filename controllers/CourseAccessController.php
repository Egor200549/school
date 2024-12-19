<?php

namespace app\controllers;

use app\models\AccessStatus;
use app\models\Course;
use app\models\CourseAccess;
use app\models\User;
use Yii;
use yii\rest\Controller;

class CourseAccessController extends Controller
{
    public function actionIndex()
    {
        return $this->render('index');
    }

    public function actionCreate()
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

        $id = Yii::$app->request->get('id');

        $course = Course::find()->where(['id_course' => $id])->one();

        if (!$course) {
            $response = $this->response;
            $response->data = [
                'code' => 404,
                'message' => 'Course Not Found',
            ];
            $response->statusCode = 404;
            return $response;
        } else {
            if (CourseAccess::find()->where(['course_id' => $course->id_course, 'student' => $user->id_user])->one()) {
                $response = $this->response;
                $response->data = [
                    'code' => 409,
                    'message' => 'The request has already been sent',
                ];
                $response->statusCode = 409;
                return $response;
            } else {
                $course_access = new CourseAccess();
                $course_access->course_id = $id;
                $course_access->student = $user->id_user;
                $course_access->save();

                $response = $this->response;
                $response->data = [
                    'status' => true
                ];
                $response->statusCode = 200;
                return $response;
            }
        }
    }

    public function actionUpdate()
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

        $id_course = Yii::$app->request->get('idCourse');

        $course = Course::find()->where(['id_course' => $id_course])->one();

        if (!$course) {
            $response = $this->response;
            $response->data = [
                'code' => 404,
                'message' => 'Course Not Found',
            ];
            $response->statusCode = 404;
            return $response;
        }

        if ($course->author != $user->id_user) {
            $response = $this->response;
            $response->data = [
                'code' => 403,
                'message' => 'Forbidden For You',
            ];
            $response->statusCode = 403;
            return $response;
        }

        $id_request = Yii::$app->request->get('idRequest');

        $request = CourseAccess::find()->where(['id_course_access' => $id_request])->one();

        if (!$request) {
            $response = $this->response;
            $response->data = [
                'code' => 404,
                'message' => 'Request Not Found',
            ];
            $response->statusCode = 404;
            return $response;
        }

        $status = AccessStatus::find()->where(['id_access_status' => $data['status_id']])->one();

        if (!$status) {
            $response = $this->response;
            $response->data = [
                'code' => 404,
                'message' => 'Status Not Found',
            ];
            $response->statusCode = 404;
            return $response;
        } else {
            $response = $this->response;
            $response->data = [
                'code' => 200,
                'status' => true,
            ];
            $response->statusCode = 200;

            $request->status_id = $data['status_id'];
            $request->updated_at = date('Y-m-d H:i:s');
            $request->save();

            return $response;
        }
    }
}
