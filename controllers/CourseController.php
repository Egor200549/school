<?php

namespace app\controllers;

use yii\rest\Controller;

class CourseController extends Controller
{
    public function actionIndex()
    {
        return $this->render('index');
    }

}
