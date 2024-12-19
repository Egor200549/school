<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "done".
 *
 * @property int $id_done
 * @property int $lesson_id
 * @property int $student
 * @property string $st_answer
 * @property string $feedback
 * @property int|null $mark
 * @property string $time_start
 * @property string $time_end
 * @property string $created_at
 * @property string|null $updated_at
 *
 * @property Lesson $lesson
 * @property User $student0
 */
class Done extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'done';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['lesson_id', 'student', 'st_answer', 'time_start', 'time_end'], 'required'],
            [['lesson_id', 'student', 'mark'], 'integer'],
            [['st_answer', 'time_start', 'time_end', 'created_at', 'updated_at'], 'safe'],
            [['lesson_id'], 'exist', 'skipOnError' => true, 'targetClass' => Lesson::class, 'targetAttribute' => ['lesson_id' => 'id_lesson']],
            [['student'], 'exist', 'skipOnError' => true, 'targetClass' => User::class, 'targetAttribute' => ['student' => 'id_user']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id_done' => 'Id Done',
            'lesson_id' => 'Lesson ID',
            'student' => 'Student',
            'st_answer' => 'St Answer',
            'feedback' => 'Feedback',
            'mark' => 'Mark',
            'time_start' => 'Time Start',
            'time_end' => 'Time End',
            'created_at' => 'Created At',
            'updated_at' => 'Updated At',
        ];
    }

    /**
     * Gets query for [[Lesson]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getLesson()
    {
        return $this->hasOne(Lesson::class, ['id_lesson' => 'lesson_id']);
    }

    /**
     * Gets query for [[Student0]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getStudent0()
    {
        return $this->hasOne(User::class, ['id_user' => 'student']);
    }
}
