<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "level".
 *
 * @property int $id_level
 * @property string $level_code
 * @property string $level_title
 * @property string $level_name
 *
 * @property Course[] $courses
 * @property User[] $users
 */
class Level extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'level';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['level_code', 'level_title', 'level_name'], 'required'],
            [['level_code', 'level_title', 'level_name'], 'string', 'max' => 255],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id_level' => 'Id Level',
            'level_code' => 'Level Code',
            'level_title' => 'Level Title',
            'level_name' => 'Level Name',
        ];
    }

    /**
     * Gets query for [[Courses]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getCourses()
    {
        return $this->hasMany(Course::class, ['level_id' => 'id_level']);
    }

    /**
     * Gets query for [[Users]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getUsers()
    {
        return $this->hasMany(User::class, ['level_id' => 'id_level']);
    }
}
