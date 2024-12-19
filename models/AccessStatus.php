<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "access_status".
 *
 * @property int $id_access_status
 * @property string $status_name
 * @property string $status_code
 *
 * @property CourseAccess[] $courseAccesses
 */
class AccessStatus extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'access_status';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['status_name', 'status_code'], 'required'],
            [['status_name', 'status_code'], 'string', 'max' => 255],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id_access_status' => 'Id Access Status',
            'status_name' => 'Status Name',
            'status_code' => 'Status Code',
        ];
    }

    /**
     * Gets query for [[CourseAccesses]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getCourseAccesses()
    {
        return $this->hasMany(CourseAccess::class, ['status_id' => 'id_access_status']);
    }
}
