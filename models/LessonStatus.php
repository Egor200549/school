<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "lesson_status".
 *
 * @property int $id_status
 * @property string $status_code
 * @property string $status_name
 *
 * @property Lesson[] $lessons
 */
class LessonStatus extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'lesson_status';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['status_code', 'status_name'], 'required'],
            [['status_code', 'status_name'], 'string', 'max' => 255],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id_status' => 'Id Status',
            'status_code' => 'Status Code',
            'status_name' => 'Status Name',
        ];
    }

    /**
     * Gets query for [[Lessons]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getLessons()
    {
        return $this->hasMany(Lesson::class, ['lesson_status' => 'id_status']);
    }
}
