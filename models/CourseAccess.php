<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "course_access".
 *
 * @property int $id_course_access
 * @property int $course_id
 * @property int $student
 * @property int $status_id
 * @property string $created_at
 * @property string|null $updated_at
 *
 * @property Course $course
 * @property AccessStatus $status
 * @property User $student0
 */
class CourseAccess extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'course_access';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['course_id', 'student'], 'required'],
            [['course_id', 'student', 'status_id'], 'integer'],
            [['created_at', 'updated_at'], 'safe'],
            [['course_id'], 'exist', 'skipOnError' => true, 'targetClass' => Course::class, 'targetAttribute' => ['course_id' => 'id_course']],
            [['student'], 'exist', 'skipOnError' => true, 'targetClass' => User::class, 'targetAttribute' => ['student' => 'id_user']],
            [['status_id'], 'exist', 'skipOnError' => true, 'targetClass' => AccessStatus::class, 'targetAttribute' => ['status_id' => 'id_access_status']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id_course_access' => 'Id Course Access',
            'course_id' => 'Course ID',
            'student' => 'Student',
            'status_id' => 'Status ID',
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
     * Gets query for [[Status]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getStatus()
    {
        return $this->hasOne(AccessStatus::class, ['id_access_status' => 'status_id']);
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
