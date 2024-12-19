<?php

namespace app\controllers;

use app\models\Course;
use app\models\Lesson;
use app\models\LessonStatus;
use app\models\Role;
use app\models\User;
use Yii;

class LessonController extends \yii\rest\Controller
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

        $data = Yii::$app->request->post();
        $lesson = new Lesson();
        $lesson->load($data, '');

        if (!$lesson->validate()) {
            $response = $this->response;
            $response->statusCode = 422;
            $response->data['code'] = 422;
            $response->data['message'] = "Validation error";
            $response->data['errors'] = $lesson->errors;
            return $response;
        }

        if (Lesson::find()->where(['course_id' => $id, 'lesson_number' => $lesson->lesson_number])->one()) {
            $response = $this->response;
            $response->statusCode = 409;
            $response->data['code'] = 409;
            $response->data['message'] = "The lesson already exists";
            return $response;
        }

        $lesson->course_id = $id;
        $lesson->save();

        $response = $this->response;
        $response->data = [
            'status' => true
        ];
        $response->statusCode = 200;
        return $response;
    }

    public function actionPublish($idLesson)
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

        if ($user->role_id != Role::find()->where(['role_code' => 'admin'])->one()->id_role) {
            $response = $this->response;
            $response->data = [
                'code' => 403,
                'message' => 'Forbidden For You',
            ];
            $response->statusCode = 403;
            return $response;
        }

        $lesson = Lesson::find()->where(['id_lesson' => $idLesson])->one();

        if (!$lesson) {
            $response = $this->response;
            $response->data = [
                'code' => 404,
                'message' => 'Lesson Not Found',
            ];
            $response->statusCode = 404;
            return $response;
        }

        $data = Yii::$app->request->getBodyParams();

        $status = LessonStatus::find()->where(['id_status' => $data['lesson_status']])->one();

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

            $lesson->lesson_status = $data['lesson_status'];
            $lesson->updated_at = date('Y-m-d H:i:s');
            $lesson->save();

            return $response;
        }
    }
}
