<?php

namespace app\models;

use Yii;
use yii\web\IdentityInterface;

/**
 * This is the model class for table "user".
 *
 * @property int $id_user
 * @property string $first_name
 * @property string $last_name
 * @property string $middle_name
 * @property string $phone
 * @property string $email
 * @property string $password
 * @property string|null $photo
 * @property int|null $level_id
 * @property int $role_id
 * @property string|null $token
 * @property int|null $check_email
 * @property string $created_at
 * @property string|null $updated_at
 *
 * @property CourseAccess[] $courseAccesses
 * @property Course[] $courses
 * @property Done[] $dones
 * @property Level $level
 * @property Role $role
 */
class User extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'user';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['first_name', 'last_name', 'middle_name', 'phone', 'email', 'password'], 'required'],
            [['level_id', 'role_id', 'check_email'], 'integer'],
            [['created_at', 'updated_at'], 'safe'],
            [['photo'], 'file', 'skipOnEmpty' => false, 'extensions' => 'png, jpg'],
            [['first_name', 'last_name', 'middle_name', 'phone', 'email', 'password', 'photo', 'token'], 'string', 'max' => 255],
            [['role_id'], 'exist', 'skipOnError' => true, 'targetClass' => Role::class, 'targetAttribute' => ['role_id' => 'id_role']],
            [['level_id'], 'exist', 'skipOnError' => true, 'targetClass' => Level::class, 'targetAttribute' => ['level_id' => 'id_level']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id_user' => 'Id User',
            'first_name' => 'First Name',
            'last_name' => 'Last Name',
            'middle_name' => 'Middle Name',
            'phone' => 'Phone',
            'email' => 'Email',
            'password' => 'Password',
            'photo' => 'Photo',
            'level_id' => 'Level ID',
            'role_id' => 'Role ID',
            'token' => 'Token',
            'check_email' => 'Check Email',
            'created_at' => 'Created At',
            'updated_at' => 'Updated At',
        ];
    }

    public static function findByToken($token)
    {
        return static::findOne(['token' => $token]);
    }

    public static function getToken()
    {
        return str_replace('Bearer ', '', Yii::$app->request->headers->get('Authorization'));
    }

    /**
     * Gets query for [[CourseAccesses]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getCourseAccesses()
    {
        return $this->hasMany(CourseAccess::class, ['student' => 'id_user']);
    }

    /**
     * Gets query for [[Courses]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getCourses()
    {
        return $this->hasMany(Course::class, ['author' => 'id_user']);
    }

    /**
     * Gets query for [[Dones]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getDones()
    {
        return $this->hasMany(Done::class, ['student' => 'id_user']);
    }

    /**
     * Gets query for [[Level]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getLevel()
    {
        return $this->hasOne(Level::class, ['id_level' => 'level_id']);
    }

    /**
     * Gets query for [[Role]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getRole()
    {
        return $this->hasOne(Role::class, ['id_role' => 'role_id']);
    }
}
