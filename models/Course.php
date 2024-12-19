<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "course".
 *
 * @property int $id_course
 * @property string $course_name
 * @property string $course_description
 * @property int $level_id
 * @property int $category_id
 * @property int $author
 * @property string $created_at
 * @property string|null $updated_at
 *
 * @property User $author0
 * @property Category $category
 * @property CourseAccess[] $courseAccesses
 * @property Lesson[] $lessons
 * @property Level $level
 */
class Course extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'course';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['course_name', 'course_description', 'level_id', 'category_id', 'author', 'created_at'], 'required'],
            [['level_id', 'category_id', 'author'], 'integer'],
            [['created_at', 'updated_at'], 'safe'],
            [['course_name', 'course_description'], 'string', 'max' => 255],
            [['category_id'], 'exist', 'skipOnError' => true, 'targetClass' => Category::class, 'targetAttribute' => ['category_id' => 'id_category']],
            [['author'], 'exist', 'skipOnError' => true, 'targetClass' => User::class, 'targetAttribute' => ['author' => 'id_user']],
            [['level_id'], 'exist', 'skipOnError' => true, 'targetClass' => Level::class, 'targetAttribute' => ['level_id' => 'id_level']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id_course' => 'Id Course',
            'course_name' => 'Course Name',
            'course_description' => 'Course Description',
            'level_id' => 'Level ID',
            'category_id' => 'Category ID',
            'author' => 'Author',
            'created_at' => 'Created At',
            'updated_at' => 'Updated At',
        ];
    }

    /**
     * Gets query for [[Author0]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getAuthor0()
    {
        return $this->hasOne(User::class, ['id_user' => 'author']);
    }

    /**
     * Gets query for [[Category]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getCategory()
    {
        return $this->hasOne(Category::class, ['id_category' => 'category_id']);
    }

    /**
     * Gets query for [[CourseAccesses]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getCourseAccesses()
    {
        return $this->hasMany(CourseAccess::class, ['course_id' => 'id_course']);
    }

    /**
     * Gets query for [[Lessons]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getLessons()
    {
        return $this->hasMany(Lesson::class, ['course_id' => 'id_course']);
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
}
