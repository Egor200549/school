<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "lesson".
 *
 * @property int $id_lesson
 * @property int $lesson_number
 * @property string $lesson_name
 * @property string $lesson_description
 * @property string $lesson_body
 * @property int $course_id
 * @property int $lesson_status
 * @property string $created_at
 * @property string|null $updated_at
 *
 * @property Course $course
 * @property Done[] $dones
 * @property LessonStatus $lessonStatus
 */
class Lesson extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'lesson';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['lesson_number', 'lesson_name', 'lesson_description', 'lesson_body'], 'required'],
            [['lesson_number', 'course_id', 'lesson_status'], 'integer'],
            [['lesson_body', 'created_at', 'updated_at'], 'safe'],
            [['lesson_name', 'lesson_description'], 'string', 'max' => 255],
            [['course_id'], 'exist', 'skipOnError' => true, 'targetClass' => Course::class, 'targetAttribute' => ['course_id' => 'id_course']],
            [['lesson_status'], 'exist', 'skipOnError' => true, 'targetClass' => LessonStatus::class, 'targetAttribute' => ['lesson_status' => 'id_status']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id_lesson' => 'Id Lesson',
            'lesson_number' => 'Lesson Number',
            'lesson_name' => 'Lesson Name',
            'lesson_description' => 'Lesson Description',
            'lesson_body' => 'Lesson Body',
            'course_id' => 'Course ID',
            'lesson_status' => 'Lesson Status',
            'created_at' => 'Created At',
            'updated_at' => 'Updated At',
        ];
    }

    /**
     * Gets query for [[Course]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getCourse()
    {
        return $this->hasOne(Course::class, ['id_course' => 'course_id']);
    }

    /**
     * Gets query for [[Dones]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getDones()
    {
        return $this->hasMany(Done::class, ['lesson_id' => 'id_lesson']);
    }

    /**
     * Gets query for [[LessonStatus]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getLessonStatus()
    {
        return $this->hasOne(LessonStatus::class, ['id_status' => 'lesson_status']);
    }
}
