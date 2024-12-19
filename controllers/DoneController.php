<?php

namespace app\controllers;

use app\models\Course;
use app\models\Done;
use app\models\Lesson;
use app\models\User;
use Yii;

class DoneController extends \yii\rest\Controller
{
    public function actionIndex()
    {
        return $this->render('index');
    }

    public function actionCreate($id)
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

        $lesson = Lesson::find()->where(['id_lesson' => $id])->one();

        if (!$lesson) {
            $response = $this->response;
            $response->data = [
                'code' => 404,
                'message' => 'Lesson Not Found',
            ];
            $response->statusCode = 404;
            return $response;
        }

        $data = Yii::$app->request->post();
        $done = new Done();
        $done->load($data, '');

        $done->lesson_id = $lesson->id_lesson;
        $done->student = $user->id_user;
        $done->time_start = date('Y-m-d H:i:s');
        $done->time_end = date('Y-m-d H:i:s');


        if (!$done->validate()) {
            $response = $this->response;
            $response->statusCode = 422;
            $response->data['code'] = 422;
            $response->data['message'] = "Validation error";
            $response->data['errors'] = $done->errors;
            return $response;
        }

        $response = $this->response;
        $response->data = [
            'code' => 200,
            'status' => true,
        ];
        $response->statusCode = 200;
        $done->save();

        return $response;
    }

    public function actionCheck($id)
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

        $done = Done::find()->where(['id_done' => $id])->one();

        if (!$done) {
            $response = $this->response;
            $response->data = [
                'code' => 404,
                'message' => 'Student Answer Not Found',
            ];
            $response->statusCode = 404;
            return $response;
        }

        $course_id = Lesson::find()->where(['id_lesson' => $done->lesson_id])->one()->course_id;
        $course = Course::find()->where(['id_course' => $course_id])->one();

        if ($course->author != $user->id_user) {
            $response = $this->response;
            $response->data = [
                'code' => 403,
                'message' => 'Forbidden For You',
            ];
            $response->statusCode = 403;
            return $response;
        }

        $data = Yii::$app->request->getBodyParams();
        $done->mark = $data['mark'];
        $done->updated_at = date('Y-m-d H:i:s');
        $done->feedback = json_encode($data['feedback'], JSON_UNESCAPED_UNICODE);
        $done->save();

        $response = $this->response;
        $response->data = [
            'code' => 200,
            'status' => true,
        ];
        $response->statusCode = 200;

        return $response;
    }
}
