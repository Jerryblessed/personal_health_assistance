BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "django_migrations" (
	"id"	integer NOT NULL,
	"app"	varchar(255) NOT NULL,
	"name"	varchar(255) NOT NULL,
	"applied"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_group_permissions" (
	"id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_user_groups" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_user_user_permissions" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_admin_log" (
	"id"	integer NOT NULL,
	"object_id"	text,
	"object_repr"	varchar(200) NOT NULL,
	"action_flag"	smallint unsigned NOT NULL CHECK("action_flag" >= 0),
	"change_message"	text NOT NULL,
	"content_type_id"	integer,
	"user_id"	integer NOT NULL,
	"action_time"	datetime NOT NULL,
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "assignment_submission" (
	"id"	integer NOT NULL,
	"file"	varchar(100) NOT NULL,
	"comment"	varchar(1000) NOT NULL,
	"date"	datetime NOT NULL,
	"assignment_id"	bigint NOT NULL,
	"user_id"	integer NOT NULL,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("assignment_id") REFERENCES "assignment_assignment"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "assignment_assignmentfilecontent" (
	"id"	integer NOT NULL,
	"file"	varchar(100) NOT NULL,
	"user_id"	integer NOT NULL,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "assignment_assignment_files" (
	"id"	integer NOT NULL,
	"assignment_id"	bigint NOT NULL,
	"assignmentfilecontent_id"	bigint NOT NULL,
	FOREIGN KEY("assignment_id") REFERENCES "assignment_assignment"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("assignmentfilecontent_id") REFERENCES "assignment_assignmentfilecontent"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "assignment_assignment" (
	"id"	integer NOT NULL,
	"title"	varchar(150) NOT NULL,
	"content"	text NOT NULL,
	"points"	integer unsigned NOT NULL CHECK("points" >= 0),
	"due"	date NOT NULL,
	"user_id"	integer NOT NULL,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_content_type" (
	"id"	integer NOT NULL,
	"app_label"	varchar(100) NOT NULL,
	"model"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_permission" (
	"id"	integer NOT NULL,
	"content_type_id"	integer NOT NULL,
	"codename"	varchar(100) NOT NULL,
	"name"	varchar(255) NOT NULL,
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_group" (
	"id"	integer NOT NULL,
	"name"	varchar(150) NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_user" (
	"id"	integer NOT NULL,
	"password"	varchar(128) NOT NULL,
	"last_login"	datetime,
	"is_superuser"	bool NOT NULL,
	"username"	varchar(150) NOT NULL UNIQUE,
	"last_name"	varchar(150) NOT NULL,
	"email"	varchar(254) NOT NULL,
	"is_staff"	bool NOT NULL,
	"is_active"	bool NOT NULL,
	"date_joined"	datetime NOT NULL,
	"first_name"	varchar(150) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "taggit_taggeditem" (
	"id"	integer NOT NULL,
	"object_id"	integer NOT NULL,
	"content_type_id"	integer NOT NULL,
	"tag_id"	integer NOT NULL,
	FOREIGN KEY("tag_id") REFERENCES "taggit_tag"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "taggit_tag" (
	"id"	integer NOT NULL,
	"name"	varchar(100) NOT NULL UNIQUE,
	"slug"	varchar(100) NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "blog_article" (
	"id"	integer NOT NULL,
	"title"	varchar(250) NOT NULL,
	"slug"	varchar(50) NOT NULL,
	"image"	varchar(100) NOT NULL,
	"image_credit"	varchar(250),
	"body"	text NOT NULL,
	"date_published"	datetime,
	"date_created"	datetime NOT NULL,
	"date_updated"	datetime NOT NULL,
	"status"	varchar(10) NOT NULL,
	"views"	integer unsigned NOT NULL CHECK("views" >= 0),
	"count_words"	varchar(50) NOT NULL,
	"read_time"	varchar(50) NOT NULL,
	"deleted"	bool NOT NULL,
	"author_id"	integer NOT NULL,
	"category_id"	integer NOT NULL,
	FOREIGN KEY("category_id") REFERENCES "blog_category"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("author_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "blog_category" (
	"id"	integer NOT NULL,
	"name"	varchar(100) NOT NULL,
	"slug"	varchar(50) NOT NULL,
	"image"	varchar(100) NOT NULL,
	"approved"	bool NOT NULL,
	"date_created"	datetime NOT NULL,
	"date_updated"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "blog_course" (
	"id"	integer NOT NULL,
	"title"	varchar(250) NOT NULL,
	"slug"	varchar(50) NOT NULL,
	"image"	varchar(100) NOT NULL,
	"image_credit"	varchar(250),
	"body"	text NOT NULL,
	"date_published"	datetime,
	"date_created"	datetime NOT NULL,
	"date_updated"	datetime NOT NULL,
	"status"	varchar(10) NOT NULL,
	"views"	integer unsigned NOT NULL CHECK("views" >= 0),
	"count_words"	varchar(50) NOT NULL,
	"read_time"	varchar(50) NOT NULL,
	"deleted"	bool NOT NULL,
	"article_id"	bigint NOT NULL,
	"author_id"	integer NOT NULL,
	FOREIGN KEY("article_id") REFERENCES "blog_article"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("author_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "blog_commentcourse" (
	"id"	integer NOT NULL,
	"name"	varchar(250) NOT NULL,
	"email"	varchar(254) NOT NULL,
	"comment"	text NOT NULL,
	"date_created"	datetime NOT NULL,
	"date_updated"	datetime NOT NULL,
	"approved"	bool NOT NULL,
	"course_id"	bigint NOT NULL,
	FOREIGN KEY("course_id") REFERENCES "blog_course"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "blog_subject" (
	"id"	integer NOT NULL,
	"title"	varchar(250) NOT NULL,
	"slug"	varchar(50) NOT NULL,
	"image"	varchar(100) NOT NULL,
	"image_credit"	varchar(250),
	"body"	text NOT NULL,
	"date_published"	datetime,
	"date_created"	datetime NOT NULL,
	"date_updated"	datetime NOT NULL,
	"status"	varchar(10) NOT NULL,
	"views"	integer unsigned NOT NULL CHECK("views" >= 0),
	"count_words"	varchar(50) NOT NULL,
	"read_time"	varchar(50) NOT NULL,
	"deleted"	bool NOT NULL,
	"author_id"	integer NOT NULL,
	"course_id"	bigint NOT NULL,
	FOREIGN KEY("author_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("course_id") REFERENCES "blog_course"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "blog_room" (
	"id"	integer NOT NULL,
	"title"	varchar(250) NOT NULL,
	"slug"	varchar(50) NOT NULL,
	"image"	varchar(100) NOT NULL,
	"image_credit"	varchar(250),
	"body"	text NOT NULL,
	"date_published"	datetime,
	"date_created"	datetime NOT NULL,
	"date_updated"	datetime NOT NULL,
	"status"	varchar(10) NOT NULL,
	"views"	integer unsigned NOT NULL CHECK("views" >= 0),
	"count_words"	varchar(50) NOT NULL,
	"read_time"	varchar(50) NOT NULL,
	"deleted"	bool NOT NULL,
	"author_id"	integer NOT NULL,
	"subject_id"	bigint NOT NULL,
	FOREIGN KEY("subject_id") REFERENCES "blog_subject"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("author_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "blog_rep" (
	"id"	integer NOT NULL,
	"title"	varchar(250) NOT NULL,
	"slug"	varchar(50) NOT NULL,
	"image"	varchar(100) NOT NULL,
	"image_credit"	varchar(250),
	"body"	text NOT NULL,
	"date_published"	datetime,
	"date_created"	datetime NOT NULL,
	"date_updated"	datetime NOT NULL,
	"status"	varchar(10) NOT NULL,
	"views"	integer unsigned NOT NULL CHECK("views" >= 0),
	"count_words"	varchar(50) NOT NULL,
	"read_time"	varchar(50) NOT NULL,
	"deleted"	bool NOT NULL,
	"author_id"	integer NOT NULL,
	"room_id"	bigint NOT NULL,
	FOREIGN KEY("room_id") REFERENCES "blog_room"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("author_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "blog_mem" (
	"id"	integer NOT NULL,
	"title"	varchar(250) NOT NULL,
	"slug"	varchar(50) NOT NULL,
	"image"	varchar(100) NOT NULL,
	"image_credit"	varchar(250),
	"body"	text NOT NULL,
	"date_published"	datetime,
	"date_created"	datetime NOT NULL,
	"date_updated"	datetime NOT NULL,
	"status"	varchar(10) NOT NULL,
	"views"	integer unsigned NOT NULL CHECK("views" >= 0),
	"count_words"	varchar(50) NOT NULL,
	"read_time"	varchar(50) NOT NULL,
	"deleted"	bool NOT NULL,
	"author_id"	integer NOT NULL,
	"rep_id"	bigint NOT NULL,
	FOREIGN KEY("author_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("rep_id") REFERENCES "blog_rep"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "blog_table" (
	"id"	integer NOT NULL,
	"title"	varchar(250) NOT NULL,
	"slug"	varchar(50) NOT NULL,
	"image"	varchar(100) NOT NULL,
	"image_credit"	varchar(250),
	"body"	text NOT NULL,
	"date_published"	datetime,
	"date_created"	datetime NOT NULL,
	"date_updated"	datetime NOT NULL,
	"status"	varchar(10) NOT NULL,
	"views"	integer unsigned NOT NULL CHECK("views" >= 0),
	"count_words"	varchar(50) NOT NULL,
	"read_time"	varchar(50) NOT NULL,
	"deleted"	bool NOT NULL,
	"author_id"	integer NOT NULL,
	"mem_id"	bigint NOT NULL,
	FOREIGN KEY("mem_id") REFERENCES "blog_mem"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("author_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "blog_chair" (
	"id"	integer NOT NULL,
	"title"	varchar(250) NOT NULL,
	"slug"	varchar(50) NOT NULL,
	"image"	varchar(100) NOT NULL,
	"image_credit"	varchar(250),
	"body"	text NOT NULL,
	"date_published"	datetime,
	"date_created"	datetime NOT NULL,
	"date_updated"	datetime NOT NULL,
	"status"	varchar(10) NOT NULL,
	"views"	integer unsigned NOT NULL CHECK("views" >= 0),
	"count_words"	varchar(50) NOT NULL,
	"read_time"	varchar(50) NOT NULL,
	"deleted"	bool NOT NULL,
	"author_id"	integer NOT NULL,
	"table_id"	bigint NOT NULL,
	"file"	varchar(100),
	FOREIGN KEY("table_id") REFERENCES "blog_table"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("author_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "blog_comment" (
	"id"	integer NOT NULL,
	"name"	varchar(250) NOT NULL,
	"email"	varchar(254) NOT NULL,
	"comment"	text NOT NULL,
	"date_created"	datetime NOT NULL,
	"date_updated"	datetime NOT NULL,
	"approved"	bool NOT NULL,
	"chair_id"	bigint NOT NULL,
	FOREIGN KEY("chair_id") REFERENCES "blog_chair"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "blog_profile" (
	"id"	integer NOT NULL,
	"image"	varchar(100) NOT NULL,
	"banner_image"	varchar(100) NOT NULL,
	"job_title"	varchar(100) NOT NULL,
	"bio"	varchar(100) NOT NULL,
	"address"	varchar(100) NOT NULL,
	"city"	varchar(100) NOT NULL,
	"country"	varchar(100) NOT NULL,
	"zip_code"	varchar(100) NOT NULL,
	"twitter_url"	varchar(250),
	"instagram_url"	varchar(250),
	"facebook_url"	varchar(250),
	"github_url"	varchar(250),
	"email_confirmed"	bool NOT NULL,
	"created_on"	datetime NOT NULL,
	"updated_on"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "blog_chair_enrolled" (
	"id"	integer NOT NULL,
	"chair_id"	bigint NOT NULL,
	"user_id"	integer NOT NULL,
	FOREIGN KEY("chair_id") REFERENCES "blog_chair"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "question_votes" (
	"id"	integer NOT NULL,
	"vote"	varchar(1) NOT NULL,
	"date"	datetime NOT NULL,
	"answer_id"	bigint NOT NULL,
	"user_id"	integer NOT NULL,
	FOREIGN KEY("answer_id") REFERENCES "question_answer"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "question_question" (
	"id"	integer NOT NULL,
	"title"	varchar(300) NOT NULL,
	"body"	text NOT NULL,
	"created_date"	datetime NOT NULL,
	"update_date"	datetime NOT NULL,
	"has_accepted_answer"	bool NOT NULL,
	"user_id"	integer NOT NULL,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "question_answer" (
	"id"	integer NOT NULL,
	"body"	text NOT NULL,
	"created_date"	datetime NOT NULL,
	"update_date"	datetime NOT NULL,
	"votes"	integer NOT NULL,
	"is_accepted_answer"	bool NOT NULL,
	"question_id"	bigint NOT NULL,
	"user_id"	integer NOT NULL,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("question_id") REFERENCES "question_question"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "quiz_answer" (
	"id"	integer NOT NULL,
	"answer_text"	varchar(900) NOT NULL,
	"is_correct"	bool NOT NULL,
	"user_id"	integer NOT NULL,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "quiz_question" (
	"id"	integer NOT NULL,
	"question_text"	varchar(900) NOT NULL,
	"points"	integer unsigned NOT NULL CHECK("points" >= 0),
	"user_id"	integer NOT NULL,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "quiz_question_answers" (
	"id"	integer NOT NULL,
	"question_id"	bigint NOT NULL,
	"answer_id"	bigint NOT NULL,
	FOREIGN KEY("question_id") REFERENCES "quiz_question"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("answer_id") REFERENCES "quiz_answer"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "quiz_quizzes_questions" (
	"id"	integer NOT NULL,
	"quizzes_id"	bigint NOT NULL,
	"question_id"	bigint NOT NULL,
	FOREIGN KEY("question_id") REFERENCES "quiz_question"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("quizzes_id") REFERENCES "quiz_quizzes"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "quiz_attempter" (
	"id"	integer NOT NULL,
	"score"	integer unsigned NOT NULL CHECK("score" >= 0),
	"completed"	datetime NOT NULL,
	"quiz_id"	bigint NOT NULL,
	"user_id"	integer NOT NULL,
	FOREIGN KEY("quiz_id") REFERENCES "quiz_quizzes"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "quiz_attempt" (
	"id"	integer NOT NULL,
	"answer_id"	bigint NOT NULL,
	"attempter_id"	bigint NOT NULL,
	"question_id"	bigint NOT NULL,
	"quiz_id"	bigint NOT NULL,
	FOREIGN KEY("answer_id") REFERENCES "quiz_answer"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("question_id") REFERENCES "quiz_question"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("attempter_id") REFERENCES "quiz_attempter"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("quiz_id") REFERENCES "quiz_quizzes"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "page_postfilecontent" (
	"id"	integer NOT NULL,
	"file"	varchar(100) NOT NULL,
	"posted"	datetime NOT NULL,
	"user_id"	integer NOT NULL,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "page_page" (
	"id"	integer NOT NULL,
	"title"	varchar(150) NOT NULL,
	"content"	text NOT NULL,
	"user_id"	integer NOT NULL,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "page_page_files" (
	"id"	integer NOT NULL,
	"page_id"	bigint NOT NULL,
	"postfilecontent_id"	bigint NOT NULL,
	FOREIGN KEY("page_id") REFERENCES "page_page"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("postfilecontent_id") REFERENCES "page_postfilecontent"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "module_module" (
	"id"	integer NOT NULL,
	"title"	varchar(150) NOT NULL,
	"hours"	integer unsigned NOT NULL CHECK("hours" >= 0),
	"user_id"	integer NOT NULL,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "module_module_assignments" (
	"id"	integer NOT NULL,
	"module_id"	bigint NOT NULL,
	"assignment_id"	bigint NOT NULL,
	FOREIGN KEY("assignment_id") REFERENCES "assignment_assignment"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("module_id") REFERENCES "module_module"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "module_module_pages" (
	"id"	integer NOT NULL,
	"module_id"	bigint NOT NULL,
	"page_id"	bigint NOT NULL,
	FOREIGN KEY("page_id") REFERENCES "page_page"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("module_id") REFERENCES "module_module"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "module_module_quizzes" (
	"id"	integer NOT NULL,
	"module_id"	bigint NOT NULL,
	"quizzes_id"	bigint NOT NULL,
	FOREIGN KEY("module_id") REFERENCES "module_module"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("quizzes_id") REFERENCES "quiz_quizzes"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "classroom_course_enrolled" (
	"id"	integer NOT NULL,
	"course_id"	char(32) NOT NULL,
	"user_id"	integer NOT NULL,
	FOREIGN KEY("course_id") REFERENCES "classroom_course"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "classroom_course_modules" (
	"id"	integer NOT NULL,
	"course_id"	char(32) NOT NULL,
	"module_id"	bigint NOT NULL,
	FOREIGN KEY("course_id") REFERENCES "classroom_course"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("module_id") REFERENCES "module_module"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "classroom_course_questions" (
	"id"	integer NOT NULL,
	"course_id"	char(32) NOT NULL,
	"question_id"	bigint NOT NULL,
	FOREIGN KEY("course_id") REFERENCES "classroom_course"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("question_id") REFERENCES "question_question"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "classroom_grade" (
	"id"	integer NOT NULL,
	"points"	integer unsigned NOT NULL CHECK("points" >= 0),
	"status"	varchar(10) NOT NULL,
	"course_id"	char(32) NOT NULL,
	"graded_by_id"	integer,
	"submission_id"	bigint NOT NULL,
	FOREIGN KEY("course_id") REFERENCES "classroom_course"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("graded_by_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("submission_id") REFERENCES "assignment_submission"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "completion_completion" (
	"id"	integer NOT NULL,
	"completed"	datetime NOT NULL,
	"assignment_id"	bigint,
	"course_id"	char(32) NOT NULL,
	"page_id"	bigint,
	"quiz_id"	bigint,
	"user_id"	integer NOT NULL,
	FOREIGN KEY("course_id") REFERENCES "classroom_course"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("page_id") REFERENCES "page_page"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("quiz_id") REFERENCES "quiz_quizzes"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("assignment_id") REFERENCES "assignment_assignment"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "course_priceplan" (
	"id"	integer NOT NULL,
	"pakg"	varchar(8) NOT NULL,
	"tittle"	varchar(100) NOT NULL,
	"foffere"	varchar(50),
	"soffere"	varchar(50),
	"toffere"	varchar(50),
	"fouoffere"	varchar(50),
	"fivoffere"	varchar(50),
	"price"	integer NOT NULL,
	"create"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "course_paidcourse" (
	"id"	integer NOT NULL,
	"course"	varchar(100) NOT NULL,
	"photo"	varchar(100) NOT NULL,
	"video"	varchar(100) NOT NULL,
	"price"	integer NOT NULL,
	"create"	datetime NOT NULL,
	"desciption"	text,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "direct_message" (
	"id"	integer NOT NULL,
	"body"	text,
	"date"	datetime NOT NULL,
	"is_read"	bool NOT NULL,
	"recipient_id"	integer NOT NULL,
	"sender_id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	FOREIGN KEY("recipient_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("sender_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "lms_contact" (
	"id"	integer NOT NULL,
	"name"	varchar(25) NOT NULL,
	"email"	varchar(254) NOT NULL,
	"subject"	varchar(100) NOT NULL,
	"msg"	text NOT NULL,
	"datetime"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "quiz_quizzes" (
	"id"	integer NOT NULL,
	"title"	varchar(200) NOT NULL,
	"description"	text NOT NULL,
	"date"	datetime NOT NULL,
	"due"	date NOT NULL,
	"allowed_attempts"	integer unsigned NOT NULL CHECK("allowed_attempts" >= 0),
	"user_id"	integer NOT NULL,
	"time_limit_mins"	integer unsigned NOT NULL CHECK("time_limit_mins" >= 0),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_session" (
	"session_key"	varchar(40) NOT NULL,
	"session_data"	text NOT NULL,
	"expire_date"	datetime NOT NULL,
	PRIMARY KEY("session_key")
);
CREATE TABLE IF NOT EXISTS "authy_profile" (
	"id"	integer NOT NULL,
	"location"	varchar(50),
	"url"	varchar(80),
	"profile_info"	text,
	"created"	date NOT NULL,
	"picture"	varchar(100),
	"banner"	varchar(100),
	"user_id"	integer NOT NULL UNIQUE,
	"select"	varchar(8),
	"address"	varchar(100) NOT NULL,
	"banner_image"	varchar(100) NOT NULL,
	"bio"	varchar(100) NOT NULL,
	"city"	varchar(100) NOT NULL,
	"country"	varchar(100) NOT NULL,
	"created_on"	datetime NOT NULL,
	"email_confirmed"	bool NOT NULL,
	"facebook_url"	varchar(250),
	"github_url"	varchar(250),
	"image"	varchar(100) NOT NULL,
	"instagram_url"	varchar(250),
	"job_title"	varchar(100) NOT NULL,
	"twitter_url"	varchar(250),
	"updated_on"	datetime NOT NULL,
	"zip_code"	varchar(100) NOT NULL,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "classroom_course" (
	"id"	char(32) NOT NULL,
	"picture"	varchar(100) NOT NULL,
	"title"	varchar(200) NOT NULL,
	"description"	varchar(300) NOT NULL,
	"syllabus"	text NOT NULL,
	"user_id"	integer NOT NULL,
	"creadit"	integer NOT NULL,
	"mem_id"	bigint NOT NULL,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("mem_id") REFERENCES "blog_mem"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "livestream_livestream" (
	"id"	integer NOT NULL,
	"body"	text,
	"is_read"	bool NOT NULL,
	"date"	datetime,
	"recipient_id"	integer NOT NULL,
	"sender_id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	FOREIGN KEY("recipient_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("sender_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
INSERT INTO "django_migrations" VALUES (1,'contenttypes','0001_initial','2023-06-10 15:56:04.973750');
INSERT INTO "django_migrations" VALUES (2,'auth','0001_initial','2023-06-10 15:56:04.993698');
INSERT INTO "django_migrations" VALUES (3,'admin','0001_initial','2023-06-10 15:56:05.009620');
INSERT INTO "django_migrations" VALUES (4,'admin','0002_logentry_remove_auto_add','2023-06-10 15:56:05.024618');
INSERT INTO "django_migrations" VALUES (5,'admin','0003_logentry_add_action_flag_choices','2023-06-10 15:56:05.034553');
INSERT INTO "django_migrations" VALUES (6,'assignment','0001_initial','2023-06-10 15:56:05.074481');
INSERT INTO "django_migrations" VALUES (7,'contenttypes','0002_remove_content_type_name','2023-06-10 15:56:05.225722');
INSERT INTO "django_migrations" VALUES (8,'auth','0002_alter_permission_name_max_length','2023-06-10 15:56:05.270647');
INSERT INTO "django_migrations" VALUES (9,'auth','0003_alter_user_email_max_length','2023-06-10 15:56:05.321504');
INSERT INTO "django_migrations" VALUES (10,'auth','0004_alter_user_username_opts','2023-06-10 15:56:05.356415');
INSERT INTO "django_migrations" VALUES (11,'auth','0005_alter_user_last_login_null','2023-06-10 15:56:05.401294');
INSERT INTO "django_migrations" VALUES (12,'auth','0006_require_contenttypes_0002','2023-06-10 15:56:05.409271');
INSERT INTO "django_migrations" VALUES (13,'auth','0007_alter_validators_add_error_messages','2023-06-10 15:56:05.431213');
INSERT INTO "django_migrations" VALUES (14,'auth','0008_alter_user_username_max_length','2023-06-10 15:56:05.447173');
INSERT INTO "django_migrations" VALUES (15,'auth','0009_alter_user_last_name_max_length','2023-06-10 15:56:05.463126');
INSERT INTO "django_migrations" VALUES (16,'auth','0010_alter_group_name_max_length','2023-06-10 15:56:05.479084');
INSERT INTO "django_migrations" VALUES (17,'auth','0011_update_proxy_permissions','2023-06-10 15:56:05.491052');
INSERT INTO "django_migrations" VALUES (18,'auth','0012_alter_user_first_name_max_length','2023-06-10 15:56:05.510002');
INSERT INTO "django_migrations" VALUES (19,'authy','0001_initial','2023-06-10 15:56:05.523963');
INSERT INTO "django_migrations" VALUES (20,'authy','0002_profile_select','2023-06-10 15:56:05.540920');
INSERT INTO "django_migrations" VALUES (21,'authy','0003_alter_profile_select','2023-06-10 15:56:05.559867');
INSERT INTO "django_migrations" VALUES (22,'authy','0004_auto_20210611_2154','2023-06-10 15:56:05.586829');
INSERT INTO "django_migrations" VALUES (23,'authy','0005_auto_20210611_2157','2023-06-10 15:56:05.611763');
INSERT INTO "django_migrations" VALUES (24,'authy','0006_alter_profile_url','2023-06-10 15:56:05.631683');
INSERT INTO "django_migrations" VALUES (25,'authy','0007_alter_profile_user','2023-06-10 15:56:05.656608');
INSERT INTO "django_migrations" VALUES (26,'authy','0008_alter_profile_url','2023-06-10 15:56:05.678549');
INSERT INTO "django_migrations" VALUES (27,'authy','0009_auto_20210613_1022','2023-06-10 15:56:05.711495');
INSERT INTO "django_migrations" VALUES (28,'taggit','0001_initial','2023-06-10 15:56:05.733416');
INSERT INTO "django_migrations" VALUES (29,'taggit','0002_auto_20150616_2121','2023-06-10 15:56:05.742379');
INSERT INTO "django_migrations" VALUES (30,'taggit','0003_taggeditem_add_unique_index','2023-06-10 15:56:05.755004');
INSERT INTO "django_migrations" VALUES (31,'taggit','0004_alter_taggeditem_content_type_alter_taggeditem_tag','2023-06-10 15:56:05.805900');
INSERT INTO "django_migrations" VALUES (32,'taggit','0005_auto_20220424_2025','2023-06-10 15:56:05.815841');
INSERT INTO "django_migrations" VALUES (33,'blog','0001_initial','2023-06-10 15:56:05.898654');
INSERT INTO "django_migrations" VALUES (34,'blog','0002_alter_article_id_alter_category_id_alter_comment_id_and_more','2023-06-10 15:56:05.986387');
INSERT INTO "django_migrations" VALUES (35,'blog','0003_remove_commentcourse_article_commentcourse_course_and_more','2023-06-10 15:56:06.140242');
INSERT INTO "django_migrations" VALUES (36,'blog','0004_alter_commentcourse_course','2023-06-10 15:56:06.191147');
INSERT INTO "django_migrations" VALUES (37,'blog','0005_table_chair','2023-06-10 15:56:06.305798');
INSERT INTO "django_migrations" VALUES (38,'blog','0006_remove_comment_article_comment_chair','2023-06-10 15:56:06.355664');
INSERT INTO "django_migrations" VALUES (39,'blog','0007_alter_comment_chair','2023-06-10 15:56:06.377605');
INSERT INTO "django_migrations" VALUES (40,'blog','0008_chair_file','2023-06-10 15:56:06.408522');
INSERT INTO "django_migrations" VALUES (41,'blog','0009_click','2023-06-10 15:56:06.444427');
INSERT INTO "django_migrations" VALUES (42,'blog','0010_alter_chair_image','2023-06-10 15:56:06.471357');
INSERT INTO "django_migrations" VALUES (43,'blog','0011_alter_category_image_alter_chair_image_credit','2023-06-10 15:56:06.527239');
INSERT INTO "django_migrations" VALUES (44,'blog','0012_alter_category_image_alter_chair_image','2023-06-10 15:56:06.643557');
INSERT INTO "django_migrations" VALUES (45,'blog','0013_admin_cart_cust_food_order','2023-06-10 15:56:06.654526');
INSERT INTO "django_migrations" VALUES (46,'blog','0014_delete_admin_delete_cart_delete_cust_delete_food_and_more','2023-06-10 15:56:06.662506');
INSERT INTO "django_migrations" VALUES (47,'blog','0015_remove_profile_user_chair_enrolled_delete_click','2023-06-10 15:56:06.716362');
INSERT INTO "django_migrations" VALUES (48,'question','0001_initial','2023-06-10 15:56:06.807120');
INSERT INTO "django_migrations" VALUES (49,'quiz','0001_initial','2023-06-10 15:56:06.932785');
INSERT INTO "django_migrations" VALUES (50,'page','0001_initial','2023-06-10 15:56:06.997610');
INSERT INTO "django_migrations" VALUES (51,'module','0001_initial','2023-06-10 15:56:07.045481');
INSERT INTO "django_migrations" VALUES (52,'classroom','0001_initial','2023-06-10 15:56:07.124272');
INSERT INTO "django_migrations" VALUES (53,'classroom','0002_rename_batch_categories_batch_category','2023-06-10 15:56:07.673671');
INSERT INTO "django_migrations" VALUES (54,'classroom','0003_category_creadit','2023-06-10 15:56:07.688631');
INSERT INTO "django_migrations" VALUES (55,'classroom','0004_auto_20210620_0158','2023-06-10 15:56:07.743519');
INSERT INTO "django_migrations" VALUES (56,'classroom','0005_alter_batch_category_title','2023-06-10 15:56:07.758444');
INSERT INTO "django_migrations" VALUES (57,'classroom','0006_alter_batch_category_title','2023-06-10 15:56:07.773439');
INSERT INTO "django_migrations" VALUES (58,'classroom','0007_article_lecture_mem_alter_category_options_and_more','2023-06-10 15:56:08.466884');
INSERT INTO "django_migrations" VALUES (59,'classroom','0008_rename_category_course_table','2023-06-10 15:56:08.522734');
INSERT INTO "django_migrations" VALUES (60,'classroom','0009_alter_category_unique_together_and_more','2023-06-10 15:56:09.319030');
INSERT INTO "django_migrations" VALUES (61,'completion','0001_initial','2023-06-10 15:56:10.100455');
INSERT INTO "django_migrations" VALUES (62,'course','0001_initial','2023-06-10 15:56:10.110428');
INSERT INTO "django_migrations" VALUES (63,'course','0002_paidcourse_desciption','2023-06-10 15:56:10.145463');
INSERT INTO "django_migrations" VALUES (64,'direct','0001_initial','2023-06-10 15:56:10.200684');
INSERT INTO "django_migrations" VALUES (65,'lms','0001_initial','2023-06-10 15:56:10.208660');
INSERT INTO "django_migrations" VALUES (66,'quiz','0002_remove_quizzes_time_limit_mins','2023-06-10 15:56:10.248557');
INSERT INTO "django_migrations" VALUES (67,'quiz','0003_quizzes_time_limit_mins','2023-06-10 15:56:10.288491');
INSERT INTO "django_migrations" VALUES (68,'sessions','0001_initial','2023-06-10 15:56:10.300415');
INSERT INTO "django_migrations" VALUES (69,'authy','0010_profile_address_profile_banner_image_profile_bio_and_more','2023-06-12 07:38:05.617066');
INSERT INTO "django_migrations" VALUES (70,'blog','0016_click','2023-06-12 07:38:05.701343');
INSERT INTO "django_migrations" VALUES (71,'classroom','0010_remove_course_table_course_mem','2023-06-14 09:33:59.561715');
INSERT INTO "django_migrations" VALUES (72,'classroom','0011_alter_course_mem','2023-06-14 09:33:59.609749');
INSERT INTO "django_migrations" VALUES (73,'classroom','0012_alter_course_mem','2023-06-14 09:33:59.657718');
INSERT INTO "django_migrations" VALUES (74,'direct','0002_livestream','2023-06-19 06:54:49.137345');
INSERT INTO "django_migrations" VALUES (75,'direct','0003_livestream_body_livestream_date_livestream_is_read','2023-06-19 07:44:03.807518');
INSERT INTO "django_migrations" VALUES (76,'direct','0004_delete_livestream','2023-06-19 08:02:03.376590');
INSERT INTO "django_migrations" VALUES (77,'livestream','0001_initial','2023-06-19 08:02:03.470203');
INSERT INTO "django_migrations" VALUES (78,'blog','0017_alter_article_unique_together_delete_click','2023-06-27 14:24:17.042919');
INSERT INTO "django_migrations" VALUES (79,'blog','0018_alter_course_unique_together','2023-06-27 14:28:45.358370');
INSERT INTO "django_admin_log" VALUES (1,'1','EIE 512',1,'[{"added": {}}]',12,1,'2023-06-10 16:11:24.925996');
INSERT INTO "django_admin_log" VALUES (2,'1','Hello',1,'[{"added": {}}]',9,1,'2023-06-10 16:16:18.874599');
INSERT INTO "django_admin_log" VALUES (3,'1','drawing',1,'[{"added": {}}]',14,1,'2023-06-10 17:14:34.222021');
INSERT INTO "django_admin_log" VALUES (4,'1','introduction',1,'[{"added": {}}]',15,1,'2023-06-10 17:17:56.396148');
INSERT INTO "django_admin_log" VALUES (5,'1','LT',1,'[{"added": {}}]',16,1,'2023-06-10 17:18:52.259725');
INSERT INTO "django_admin_log" VALUES (6,'1','hello',1,'[{"added": {}}]',17,1,'2023-06-10 17:19:30.447076');
INSERT INTO "django_admin_log" VALUES (7,'1','thanks',1,'[{"added": {}}]',18,1,'2023-06-10 17:19:51.225451');
INSERT INTO "django_admin_log" VALUES (8,'1','now',1,'[{"added": {}}]',19,1,'2023-06-10 17:20:12.669766');
INSERT INTO "django_admin_log" VALUES (9,'1','PostFileContent object (1)',1,'[{"added": {}}]',25,1,'2023-06-10 17:22:38.797216');
INSERT INTO "django_admin_log" VALUES (10,'1','n',1,'[{"added": {}}]',26,1,'2023-06-10 17:23:00.604275');
INSERT INTO "django_admin_log" VALUES (11,'1','God kind of Love',1,'[{"added": {}}]',27,1,'2023-06-10 17:24:03.746166');
INSERT INTO "django_admin_log" VALUES (12,'1','what is the meaning of john 3:16',1,'[{"added": {}}]',28,1,'2023-06-10 17:24:05.473137');
INSERT INTO "django_admin_log" VALUES (13,'1','now',1,'[{"added": {}}]',29,1,'2023-06-10 17:24:08.022117');
INSERT INTO "django_admin_log" VALUES (14,'1','AssignmentFileContent object (1)',1,'[{"added": {}}]',34,1,'2023-06-10 17:24:48.363780');
INSERT INTO "django_admin_log" VALUES (15,'1','rrr',1,'[{"added": {}}]',32,1,'2023-06-10 17:25:17.020215');
INSERT INTO "django_admin_log" VALUES (16,'1','Gender',1,'[{"added": {}}]',24,1,'2023-06-10 17:25:18.655589');
INSERT INTO "django_admin_log" VALUES (17,'2','main',3,'',21,1,'2023-06-11 16:13:12.696502');
INSERT INTO "django_admin_log" VALUES (18,'4','Oluwasyi',1,'[{"added": {}}]',4,1,'2023-06-11 16:14:21.292986');
INSERT INTO "django_admin_log" VALUES (19,'4','Oluwasyi',2,'[{"changed": {"fields": ["Picture"]}}]',21,1,'2023-06-11 16:22:08.211101');
INSERT INTO "django_admin_log" VALUES (20,'1','admin',2,'[{"changed": {"fields": ["Picture"]}}]',21,1,'2023-06-11 16:22:16.420811');
INSERT INTO "django_admin_log" VALUES (21,'1','admin',2,'[{"changed": {"fields": ["Location", "Package", "Profile info", "Picture", "Image"]}}]',21,1,'2023-06-12 07:47:08.890608');
INSERT INTO "django_admin_log" VALUES (22,'1','admin',2,'[{"changed": {"fields": ["Banner image"]}}]',21,1,'2023-06-12 07:47:35.787002');
INSERT INTO "django_admin_log" VALUES (23,'1','w',1,'[{"added": {}}]',20,1,'2023-06-12 07:56:46.245818');
INSERT INTO "django_admin_log" VALUES (24,'1','Gender',1,'[{"added": {}}]',37,1,'2023-06-12 08:01:34.744284');
INSERT INTO "django_admin_log" VALUES (25,'4c1c48f8-956e-4033-ad68-591e9185d302','Gender',1,'[{"added": {}}]',22,1,'2023-06-12 08:01:43.201151');
INSERT INTO "django_admin_log" VALUES (26,'4c1c48f8-956e-4033-ad68-591e9185d302','Gender',2,'[{"changed": {"fields": ["Description"]}}]',22,1,'2023-06-12 08:52:12.707984');
INSERT INTO "django_admin_log" VALUES (27,'2247895b-1670-4548-b511-309e48057308','Gender',1,'[{"added": {}}]',22,1,'2023-06-13 09:42:54.083372');
INSERT INTO "django_admin_log" VALUES (28,'2','Geography',1,'[{"added": {}}]',24,1,'2023-06-13 16:48:03.777937');
INSERT INTO "django_admin_log" VALUES (29,'32edab81-0c10-4129-95ca-e3bc24f2d97f','Farming',1,'[{"added": {}}]',22,1,'2023-06-14 06:19:40.952709');
INSERT INTO "django_admin_log" VALUES (30,'498202a2-0223-4bca-b224-432bfc5a6405','breaking of bread',1,'[{"added": {}}]',22,1,'2023-06-14 06:22:01.507733');
INSERT INTO "django_admin_log" VALUES (31,'2','ynnn',1,'[{"added": {}}]',19,1,'2023-06-14 08:40:08.430832');
INSERT INTO "django_admin_log" VALUES (32,'8cebcb26-5f5d-4069-88a2-36002504375e','Gender',1,'[{"added": {}}]',22,1,'2023-06-14 08:40:44.052467');
INSERT INTO "django_admin_log" VALUES (33,'3','clear',2,'[{"changed": {"fields": ["Picture"]}}]',21,3,'2023-06-14 11:18:27.347249');
INSERT INTO "django_admin_log" VALUES (34,'3','clear',2,'[{"changed": {"fields": ["Image"]}}]',21,3,'2023-06-14 11:19:09.404949');
INSERT INTO "django_admin_log" VALUES (35,'8cebcb26-5f5d-4069-88a2-36002504375e','Gender',2,'[{"changed": {"fields": ["Enrolled"]}}]',22,3,'2023-06-15 13:52:34.642705');
INSERT INTO "django_admin_log" VALUES (36,'5','Peter',2,'[{"changed": {"fields": ["password"]}}]',4,1,'2023-06-16 08:58:15.557664');
INSERT INTO "django_admin_log" VALUES (37,'8cebcb26-5f5d-4069-88a2-36002504375e','Gender',2,'[{"changed": {"fields": ["Enrolled"]}}]',22,1,'2023-06-16 09:00:18.814439');
INSERT INTO "django_admin_log" VALUES (38,'3','clear',2,'[{"changed": {"fields": ["Picture"]}}]',21,3,'2023-06-16 15:20:18.838259');
INSERT INTO "django_admin_log" VALUES (39,'1','Covenant University',2,'[{"changed": {"fields": ["Title", "Slug", "Image"]}}]',9,3,'2023-06-16 19:11:48.836973');
INSERT INTO "django_admin_log" VALUES (40,'1','LT',2,'[{"changed": {"fields": ["Image"]}}]',16,3,'2023-06-16 19:12:16.133727');
INSERT INTO "django_admin_log" VALUES (41,'1','Gender',2,'[{"changed": {"fields": ["Quizzes", "Assignments"]}}]',24,3,'2023-06-16 19:13:48.990169');
INSERT INTO "django_admin_log" VALUES (42,'1','Gender',2,'[{"changed": {"fields": ["Pages"]}}]',24,1,'2023-06-17 08:19:03.510076');
INSERT INTO "django_admin_log" VALUES (43,'2','Geography',2,'[{"changed": {"fields": ["Pages"]}}]',24,1,'2023-06-17 08:48:27.564394');
INSERT INTO "django_admin_log" VALUES (44,'498202a2-0223-4bca-b224-432bfc5a6405','breaking of bread',2,'[]',22,1,'2023-06-17 08:48:37.397806');
INSERT INTO "django_admin_log" VALUES (45,'1','Gender',2,'[{"changed": {"fields": ["Quizzes"]}}]',24,1,'2023-06-17 13:42:50.863342');
INSERT INTO "django_admin_log" VALUES (46,'1','Gender',2,'[{"changed": {"fields": ["Quizzes"]}}]',24,1,'2023-06-17 13:44:11.440182');
INSERT INTO "django_admin_log" VALUES (47,'4','Civic education',1,'[{"added": {}}]',29,1,'2023-06-17 13:45:32.297810');
INSERT INTO "django_admin_log" VALUES (48,'1','Gender',2,'[{"changed": {"fields": ["Quizzes"]}}]',24,1,'2023-06-17 13:45:37.183131');
INSERT INTO "django_admin_log" VALUES (49,'4','Civic education',2,'[{"changed": {"fields": ["Time limit mins"]}}]',29,1,'2023-06-17 14:08:33.811033');
INSERT INTO "django_admin_log" VALUES (50,'15','Livestream object (15)',3,'',45,1,'2023-06-19 10:48:32.731306');
INSERT INTO "django_admin_log" VALUES (51,'14','Livestream object (14)',3,'',45,1,'2023-06-19 10:48:32.746929');
INSERT INTO "django_admin_log" VALUES (52,'13','Livestream object (13)',3,'',45,1,'2023-06-19 10:48:32.856281');
INSERT INTO "django_admin_log" VALUES (53,'12','Livestream object (12)',3,'',45,1,'2023-06-19 10:48:32.871905');
INSERT INTO "django_admin_log" VALUES (54,'11','Livestream object (11)',3,'',45,1,'2023-06-19 10:48:32.887564');
INSERT INTO "django_admin_log" VALUES (55,'10','Livestream object (10)',3,'',45,1,'2023-06-19 10:48:32.903141');
INSERT INTO "django_admin_log" VALUES (56,'9','Livestream object (9)',3,'',45,1,'2023-06-19 10:48:32.950011');
INSERT INTO "django_admin_log" VALUES (57,'8','Livestream object (8)',3,'',45,1,'2023-06-19 10:48:32.981400');
INSERT INTO "django_admin_log" VALUES (58,'7','Livestream object (7)',3,'',45,1,'2023-06-19 10:48:33.028266');
INSERT INTO "django_admin_log" VALUES (59,'6','Livestream object (6)',3,'',45,1,'2023-06-19 10:48:33.059354');
INSERT INTO "django_admin_log" VALUES (60,'5','Livestream object (5)',3,'',45,1,'2023-06-19 10:48:33.106220');
INSERT INTO "django_admin_log" VALUES (61,'4','Livestream object (4)',3,'',45,1,'2023-06-19 10:48:33.137465');
INSERT INTO "django_admin_log" VALUES (62,'3','Livestream object (3)',3,'',45,1,'2023-06-19 10:48:33.153351');
INSERT INTO "django_admin_log" VALUES (63,'2','Livestream object (2)',3,'',45,1,'2023-06-19 10:48:33.199949');
INSERT INTO "django_admin_log" VALUES (64,'1','Livestream object (1)',3,'',45,1,'2023-06-19 10:48:33.215845');
INSERT INTO "django_admin_log" VALUES (65,'16','Livestream object (16)',3,'',45,1,'2023-06-19 10:56:33.541627');
INSERT INTO "django_admin_log" VALUES (66,'1','UG',2,'[{"changed": {"fields": ["Name"]}}]',12,1,'2023-06-20 08:30:52.262037');
INSERT INTO "django_admin_log" VALUES (67,'2','PG',1,'[{"added": {}}]',12,1,'2023-06-20 08:30:57.479219');
INSERT INTO "django_admin_log" VALUES (68,'2','adekunle ajasin university',1,'[{"added": {}}]',9,1,'2023-06-20 08:32:23.539646');
INSERT INTO "django_admin_log" VALUES (69,'3','Adeleke university',1,'[{"added": {}}]',9,1,'2023-06-20 08:33:52.311808');
INSERT INTO "django_admin_log" VALUES (70,'4','Afe Babalola university',1,'[{"added": {}}]',9,1,'2023-06-20 08:35:31.073556');
INSERT INTO "django_admin_log" VALUES (71,'5','patience',2,'[{"changed": {"fields": ["Image"]}}]',18,1,'2023-06-20 20:26:13.501322');
INSERT INTO "django_admin_log" VALUES (72,'4','peace',2,'[{"changed": {"fields": ["Image"]}}]',18,1,'2023-06-20 20:26:26.113194');
INSERT INTO "django_admin_log" VALUES (73,'3','joy',2,'[{"changed": {"fields": ["Image"]}}]',18,1,'2023-06-20 20:26:41.643957');
INSERT INTO "django_admin_log" VALUES (74,'2','laugh',3,'',18,1,'2023-06-20 20:27:01.807257');
INSERT INTO "django_admin_log" VALUES (75,'1','thanks',3,'',18,1,'2023-06-20 20:27:01.807257');
INSERT INTO "django_admin_log" VALUES (76,'4','Afe Babalola university',3,'',9,1,'2023-06-23 13:07:51.177613');
INSERT INTO "django_admin_log" VALUES (77,'3','Adeleke university',3,'',9,1,'2023-06-23 13:07:51.929920');
INSERT INTO "django_admin_log" VALUES (78,'2','adekunle ajasin university',3,'',9,1,'2023-06-23 13:07:51.992384');
INSERT INTO "django_admin_log" VALUES (79,'1','cmsss',2,'[{"changed": {"fields": ["Title", "Slug"]}}]',14,1,'2023-06-23 13:09:46.667707');
INSERT INTO "django_admin_log" VALUES (80,'2','coe',1,'[{"added": {}}]',14,1,'2023-06-23 13:10:45.817968');
INSERT INTO "django_admin_log" VALUES (81,'2','coe',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2023-06-23 13:10:54.349840');
INSERT INTO "django_admin_log" VALUES (82,'1','cmss',2,'[{"changed": {"fields": ["Title", "Slug"]}}]',14,1,'2023-06-23 13:11:06.548154');
INSERT INTO "django_admin_log" VALUES (83,'2','coe',2,'[{"changed": {"fields": ["Image", "Status"]}}]',14,1,'2023-06-23 13:11:42.560517');
INSERT INTO "django_admin_log" VALUES (84,'1','cmss',2,'[{"changed": {"fields": ["Image"]}}]',14,1,'2023-06-23 13:11:56.387053');
INSERT INTO "django_admin_log" VALUES (85,'2','coe',2,'[]',14,1,'2023-06-23 13:29:09.276418');
INSERT INTO "django_admin_log" VALUES (86,'2','coe',3,'',14,1,'2023-06-23 13:30:47.899928');
INSERT INTO "django_admin_log" VALUES (87,'3','COE',1,'[{"added": {}}]',14,1,'2023-06-23 13:31:15.190016');
INSERT INTO "django_admin_log" VALUES (88,'1','Alpha semester',2,'[{"changed": {"fields": ["Title", "Slug"]}}]',15,1,'2023-06-23 13:32:06.757698');
INSERT INTO "django_admin_log" VALUES (89,'2','Alpha-Semester',1,'[{"added": {}}]',15,1,'2023-06-23 13:32:51.913830');
INSERT INTO "django_admin_log" VALUES (90,'2','Alpha-Semester',2,'[{"changed": {"fields": ["Status"]}}]',15,1,'2023-06-23 13:33:12.822393');
INSERT INTO "django_admin_log" VALUES (91,'2','Alpha-Semester',2,'[{"changed": {"fields": ["Slug"]}}]',15,1,'2023-06-23 13:51:02.078808');
INSERT INTO "django_admin_log" VALUES (92,'1','Alpha semester',2,'[{"changed": {"fields": ["Slug"]}}]',15,1,'2023-06-23 13:51:28.373449');
INSERT INTO "django_admin_log" VALUES (93,'1','Alpha-semester',2,'[{"changed": {"fields": ["Title", "Slug"]}}]',15,1,'2023-06-23 13:52:18.454321');
INSERT INTO "django_admin_log" VALUES (94,'1','Alpha-semester',2,'[{"changed": {"fields": ["Slug"]}}]',15,1,'2023-06-23 13:52:28.673604');
INSERT INTO "django_admin_log" VALUES (95,'1','Alpha-semester',3,'',15,1,'2023-06-23 13:52:43.075342');
INSERT INTO "django_admin_log" VALUES (96,'3','Alpha-semester',1,'[{"added": {}}]',15,1,'2023-06-23 13:53:38.467564');
INSERT INTO "django_admin_log" VALUES (97,'2','Alpha-Semester',2,'[{"changed": {"fields": ["Course"]}}]',15,1,'2023-06-23 13:54:41.652895');
INSERT INTO "django_admin_log" VALUES (98,'3','Alpha-semester',2,'[{"changed": {"fields": ["Slug"]}}]',15,1,'2023-06-23 13:54:58.381431');
INSERT INTO "django_admin_log" VALUES (99,'2','Alpha-Semester',3,'',15,1,'2023-06-23 13:55:24.676080');
INSERT INTO "django_admin_log" VALUES (100,'3','Alpha semester',2,'[{"changed": {"fields": ["Title"]}}]',15,1,'2023-06-23 13:55:47.353520');
INSERT INTO "django_admin_log" VALUES (101,'2','100 Level',1,'[{"added": {}}]',16,1,'2023-06-23 13:58:05.489129');
INSERT INTO "django_admin_log" VALUES (102,'2','psy 111',1,'[{"added": {}}]',17,1,'2023-06-23 13:58:54.793505');
INSERT INTO "django_admin_log" VALUES (103,'6','Test 1',1,'[{"added": {}}]',18,1,'2023-06-23 14:00:51.778473');
INSERT INTO "django_admin_log" VALUES (104,'d04c389e-701d-4243-be96-ba4df73517e3','GEC 321 Examination',1,'[{"added": {}}]',22,1,'2023-06-23 14:02:16.638490');
INSERT INTO "django_admin_log" VALUES (105,'1','Gec 321',2,'[{"changed": {"fields": ["Title"]}}]',24,1,'2023-06-23 14:03:15.376070');
INSERT INTO "django_admin_log" VALUES (106,'2','PG',2,'[{"changed": {"fields": ["Image"]}}]',12,1,'2023-06-23 14:19:41.010028');
INSERT INTO "django_admin_log" VALUES (107,'1','UG',2,'[{"changed": {"fields": ["Image"]}}]',12,1,'2023-06-23 14:19:49.894740');
INSERT INTO "django_admin_log" VALUES (108,'3','Alpha semester',2,'[{"changed": {"fields": ["Image"]}}]',15,1,'2023-06-23 14:20:26.951023');
INSERT INTO "django_admin_log" VALUES (109,'4','Gendern',3,'',24,1,'2023-06-23 14:22:05.776978');
INSERT INTO "django_admin_log" VALUES (110,'2','GEC 321',2,'[{"changed": {"fields": ["Title", "Description"]}}]',29,1,'2023-06-23 14:27:17.213814');
INSERT INTO "django_admin_log" VALUES (111,'4','GEC 226',2,'[{"changed": {"fields": ["Title"]}}]',29,1,'2023-06-24 08:32:37.545837');
INSERT INTO "django_admin_log" VALUES (112,'6','y w.r.t to x',1,'[{"added": {}}]',27,1,'2023-06-24 09:40:59.407635');
INSERT INTO "django_admin_log" VALUES (113,'7','dy divided by dx plus 2',1,'[{"added": {}}]',27,1,'2023-06-24 09:41:27.471577');
INSERT INTO "django_admin_log" VALUES (114,'8','all of the above',1,'[{"added": {}}]',27,1,'2023-06-24 09:41:44.245819');
INSERT INTO "django_admin_log" VALUES (115,'3','what does dy/dx mean',1,'[{"added": {}}]',28,1,'2023-06-24 09:41:51.690865');
INSERT INTO "django_admin_log" VALUES (116,'4','GEC 226',2,'[{"changed": {"fields": ["Questions"]}}]',29,1,'2023-06-24 09:42:07.543336');
INSERT INTO "django_admin_log" VALUES (117,'4','GEC 226',2,'[{"changed": {"fields": ["Time limit mins"]}}]',29,1,'2023-06-24 14:30:51.478847');
INSERT INTO "django_admin_log" VALUES (118,'9','The application of sciencef',1,'[{"added": {}}]',27,1,'2023-06-24 14:31:33.545477');
INSERT INTO "django_admin_log" VALUES (119,'10','sleeping and doing nothing always',1,'[{"added": {}}]',27,1,'2023-06-24 14:31:56.622776');
INSERT INTO "django_admin_log" VALUES (120,'10','sleeping and doing nothing always',2,'[{"changed": {"fields": ["Is correct"]}}]',27,1,'2023-06-24 14:32:14.653681');
INSERT INTO "django_admin_log" VALUES (121,'2','what is the meaning of engineering',2,'[{"changed": {"fields": ["Question text", "Answers"]}}]',28,1,'2023-06-24 14:32:59.604607');
INSERT INTO "django_admin_log" VALUES (122,'1','PostFileContent object (1)',2,'[{"changed": {"fields": ["File"]}}]',25,1,'2023-06-24 15:57:31.000853');
INSERT INTO "django_admin_log" VALUES (123,'4','gig-l',1,'[{"added": {}}]',15,1,'2023-06-26 14:21:39.091310');
INSERT INTO "django_admin_log" VALUES (124,'7','Gendersas',1,'[{"added": {}}]',18,1,'2023-06-26 14:39:50.323490');
INSERT INTO "django_admin_log" VALUES (125,'5','ynnn',1,'[{"added": {}}]',15,1,'2023-06-26 14:44:54.797962');
INSERT INTO "django_admin_log" VALUES (126,'3','hello sir',1,'[{"added": {}}]',17,1,'2023-06-26 14:48:52.180311');
INSERT INTO "django_admin_log" VALUES (127,'3','hi',1,'[{"added": {}}]',16,1,'2023-06-26 14:51:06.965492');
INSERT INTO "django_admin_log" VALUES (128,'4','100 level',1,'[{"added": {}}]',17,1,'2023-06-27 13:57:58.780192');
INSERT INTO "django_admin_log" VALUES (129,'4','hello sirr',2,'[{"changed": {"fields": ["Title", "Slug"]}}]',17,1,'2023-06-27 13:59:13.642035');
INSERT INTO "django_admin_log" VALUES (130,'5','Covenant University',1,'[{"added": {}}]',9,1,'2023-06-27 14:25:05.909032');
INSERT INTO "django_admin_log" VALUES (131,'5','Covenant University',3,'',9,1,'2023-06-27 15:31:30.178220');
INSERT INTO "django_admin_log" VALUES (132,'d04c389e-701d-4243-be96-ba4df73517e3','GEC 321 Examination',2,'[{"changed": {"fields": ["Mem"]}}]',22,1,'2023-06-27 16:25:28.400796');
INSERT INTO "django_admin_log" VALUES (133,'6','Test 1b',2,'[{"changed": {"fields": ["Title"]}}]',18,1,'2023-06-27 16:26:46.154006');
INSERT INTO "django_admin_log" VALUES (134,'d04c389e-701d-4243-be96-ba4df73517e3','GEC 321 Examination',2,'[{"changed": {"fields": ["Mem"]}}]',22,1,'2023-06-27 16:27:26.663665');
INSERT INTO "django_admin_log" VALUES (135,'3','b',1,'[{"added": {}}]',19,1,'2023-06-27 16:28:13.810533');
INSERT INTO "django_admin_log" VALUES (136,'2a0f3735-fc10-4f8f-908f-12b5439dad01','Gender',1,'[{"added": {}}]',22,1,'2023-06-27 17:27:01.981757');
INSERT INTO "django_admin_log" VALUES (137,'1','Thanks giving question',2,'[{"changed": {"fields": ["Title", "Body"]}}]',37,1,'2023-06-27 23:05:59.122841');
INSERT INTO "django_admin_log" VALUES (138,'2a0f3735-fc10-4f8f-908f-12b5439dad01','Gender',2,'[{"changed": {"fields": ["User"]}}]',22,1,'2023-06-27 23:07:41.516612');
INSERT INTO "django_admin_log" VALUES (139,'2a0f3735-fc10-4f8f-908f-12b5439dad01','Gender',2,'[{"changed": {"fields": ["User"]}}]',22,1,'2023-06-27 23:08:21.757151');
INSERT INTO "django_admin_log" VALUES (140,'1','Covenant University',2,'[{"changed": {"fields": ["Slug"]}}]',9,1,'2023-06-29 15:28:00.300296');
INSERT INTO "django_admin_log" VALUES (141,'1','Covenant University PG',2,'[{"changed": {"fields": ["Title"]}}]',9,1,'2023-06-29 15:28:09.386635');
INSERT INTO "django_admin_log" VALUES (142,'1','Covenant University UG',2,'[{"changed": {"fields": ["Title"]}}]',9,1,'2023-06-29 15:28:28.552569');
INSERT INTO "django_admin_log" VALUES (143,'6','Covenant University PG',1,'[{"added": {}}]',9,1,'2023-06-29 15:29:04.838862');
INSERT INTO "django_admin_log" VALUES (144,'3','COE UG',2,'[{"changed": {"fields": ["Title"]}}]',14,1,'2023-06-29 15:29:51.539007');
INSERT INTO "django_admin_log" VALUES (145,'1','CMSS UG',2,'[{"changed": {"fields": ["Title"]}}]',14,1,'2023-06-29 15:30:00.694121');
INSERT INTO "django_admin_log" VALUES (146,'4','CLDS UG',1,'[{"added": {}}]',14,1,'2023-06-29 15:30:24.180213');
INSERT INTO "django_admin_log" VALUES (147,'5','CEDS-UG',1,'[{"added": {}}]',14,1,'2023-06-29 15:30:51.057447');
INSERT INTO "django_admin_log" VALUES (148,'5','CEDS UG',2,'[{"changed": {"fields": ["Title", "Image credit"]}}]',14,1,'2023-06-29 15:31:03.410058');
INSERT INTO "django_admin_log" VALUES (149,'5','100 Level COE',2,'[{"changed": {"fields": ["Title", "Status"]}}]',15,1,'2023-06-29 15:31:55.216757');
INSERT INTO "django_admin_log" VALUES (150,'4','Alpha Semester COE',2,'[{"changed": {"fields": ["Title", "Status"]}}]',15,1,'2023-06-29 15:34:11.301716');
INSERT INTO "django_admin_log" VALUES (151,'3','Omega semester COE',2,'[{"changed": {"fields": ["Title"]}}]',15,1,'2023-06-29 15:34:33.790835');
INSERT INTO "django_admin_log" VALUES (152,'5','100 Level COE',3,'',15,1,'2023-06-29 15:34:46.579169');
INSERT INTO "django_admin_log" VALUES (153,'3','100 Level COE',2,'[{"changed": {"fields": ["Subject", "Title", "Status"]}}]',16,1,'2023-06-29 15:40:41.044846');
INSERT INTO "django_admin_log" VALUES (154,'2','200 Level COE',2,'[{"changed": {"fields": ["Subject", "Title"]}}]',16,1,'2023-06-29 15:41:55.866665');
INSERT INTO "django_admin_log" VALUES (155,'4','300 Level coe',1,'[{"added": {}}]',16,1,'2023-06-29 15:42:19.757740');
INSERT INTO "django_admin_log" VALUES (156,'5','400 Level COE',1,'[{"added": {}}]',16,1,'2023-06-29 15:42:36.352918');
INSERT INTO "django_admin_log" VALUES (157,'6','500 Level COE',1,'[{"added": {}}]',16,1,'2023-06-29 15:43:14.324075');
INSERT INTO "django_admin_log" VALUES (158,'3','PHY 111',2,'[{"changed": {"fields": ["Room", "Title", "Status"]}}]',17,1,'2023-06-29 15:45:09.354684');
INSERT INTO "django_admin_log" VALUES (159,'2','GEC 117',2,'[{"changed": {"fields": ["Room", "Title"]}}]',17,1,'2023-06-29 15:45:33.111694');
INSERT INTO "django_admin_log" VALUES (160,'4','CHM 111',2,'[{"changed": {"fields": ["Title"]}}]',17,1,'2023-06-29 15:45:47.355708');
INSERT INTO "django_admin_log" VALUES (161,'5','MAT 111',1,'[{"added": {}}]',17,1,'2023-06-29 15:46:26.703451');
INSERT INTO "django_admin_log" VALUES (162,'6','MAT 112',1,'[{"added": {}}]',17,1,'2023-06-29 15:46:46.957150');
INSERT INTO "django_admin_log" VALUES (163,'7','CHM 112',1,'[{"added": {}}]',17,1,'2023-06-29 15:47:09.698684');
INSERT INTO "django_admin_log" VALUES (164,'7','skyline uni ug',1,'[{"added": {}}]',9,1,'2023-06-29 16:24:38.137071');
INSERT INTO "django_admin_log" VALUES (165,'7','skyline uni ug',2,'[{"changed": {"fields": ["Image"]}}]',9,1,'2023-06-29 16:24:51.711142');
INSERT INTO "django_admin_log" VALUES (166,'8','AKWA IBOM STATE UNIVERSITY UG',1,'[{"added": {}}]',9,1,'2023-06-29 16:25:53.465595');
INSERT INTO "django_admin_log" VALUES (167,'8','AKWA IBOM STATE UNIVERSITY UG',2,'[]',9,1,'2023-06-29 16:26:43.649446');
INSERT INTO "django_admin_log" VALUES (168,'9','Afe Babalola UG',1,'[{"added": {}}]',9,1,'2023-06-29 16:27:16.623111');
INSERT INTO "django_admin_log" VALUES (169,'8','AKWA IBOM STATE UG',2,'[{"changed": {"fields": ["Title"]}}]',9,1,'2023-06-29 16:27:25.233616');
INSERT INTO "django_admin_log" VALUES (170,'8','Akwa Ibom State UG',2,'[{"changed": {"fields": ["Title"]}}]',9,1,'2023-06-29 16:27:51.154852');
INSERT INTO "django_admin_log" VALUES (171,'10','al - hikmah PG',1,'[{"added": {}}]',9,1,'2023-06-29 16:29:36.226914');
INSERT INTO "django_admin_log" VALUES (172,'11','ahmadu bello university UG',1,'[{"added": {}}]',9,1,'2023-06-29 16:30:47.904907');
INSERT INTO "django_admin_log" VALUES (173,'12','ambrose alli UG',1,'[{"added": {}}]',9,1,'2023-06-29 16:31:27.276187');
INSERT INTO "django_admin_log" VALUES (174,'13','american university of nigeria UG',1,'[{"added": {}}]',9,1,'2023-06-29 16:32:43.186868');
INSERT INTO "django_admin_log" VALUES (175,'14','Babcock university UG',1,'[{"added": {}}]',9,1,'2023-06-29 16:33:38.510060');
INSERT INTO "django_admin_log" VALUES (176,'15','Bakassi Technical University UG',1,'[{"added": {}}]',9,1,'2023-06-29 16:34:32.007205');
INSERT INTO "django_admin_log" VALUES (177,'16','bayero university UG',1,'[{"added": {}}]',9,1,'2023-06-29 16:35:22.993701');
INSERT INTO "django_admin_log" VALUES (178,'17','Baze University UG',1,'[{"added": {}}]',9,1,'2023-06-29 16:35:53.488901');
INSERT INTO "django_admin_log" VALUES (179,'18','benson idahosa university UG',1,'[{"added": {}}]',9,1,'2023-06-29 16:36:44.775579');
INSERT INTO "django_admin_log" VALUES (180,'7','Skyline uni ug',2,'[{"changed": {"fields": ["Title"]}}]',9,1,'2023-06-29 16:49:39.577506');
INSERT INTO "django_admin_log" VALUES (181,'3','100 Level',2,'[{"changed": {"fields": ["Title"]}}]',15,1,'2023-06-29 17:03:27.378802');
INSERT INTO "django_admin_log" VALUES (182,'3','100 Level',2,'[{"changed": {"fields": ["Status"]}}]',15,1,'2023-06-29 17:03:35.461502');
INSERT INTO "django_admin_log" VALUES (183,'6','200 Level',1,'[{"added": {}}]',15,1,'2023-06-29 17:03:53.129413');
INSERT INTO "django_admin_log" VALUES (184,'7','300 Level',1,'[{"added": {}}]',15,1,'2023-06-29 17:04:07.206986');
INSERT INTO "django_admin_log" VALUES (185,'8','400 Level',1,'[{"added": {}}]',15,1,'2023-06-29 17:04:23.817160');
INSERT INTO "django_admin_log" VALUES (186,'3','100 Level',2,'[{"changed": {"fields": ["Status"]}}]',15,1,'2023-06-29 17:04:46.549184');
INSERT INTO "django_admin_log" VALUES (187,'9','500 Level',1,'[{"added": {}}]',15,1,'2023-06-29 17:05:04.733424');
INSERT INTO "django_admin_log" VALUES (188,'9','500 Level COE',2,'[{"changed": {"fields": ["Title"]}}]',15,1,'2023-06-29 17:06:07.196354');
INSERT INTO "django_admin_log" VALUES (189,'8','400 Level COE',2,'[{"changed": {"fields": ["Title"]}}]',15,1,'2023-06-29 17:06:13.938377');
INSERT INTO "django_admin_log" VALUES (190,'7','300 Level COE',2,'[{"changed": {"fields": ["Title"]}}]',15,1,'2023-06-29 17:06:20.225424');
INSERT INTO "django_admin_log" VALUES (191,'6','200 Level COE',2,'[{"changed": {"fields": ["Title"]}}]',15,1,'2023-06-29 17:06:29.768839');
INSERT INTO "django_admin_log" VALUES (192,'3','100 Level COE',2,'[{"changed": {"fields": ["Title"]}}]',15,1,'2023-06-29 17:06:42.234850');
INSERT INTO "django_admin_log" VALUES (193,'4','Alpha Semester COE',2,'[{"changed": {"fields": ["Status"]}}]',15,1,'2023-06-29 17:06:49.060613');
INSERT INTO "django_admin_log" VALUES (194,'6','Aplha semester 100 COE',2,'[{"changed": {"fields": ["Subject", "Title"]}}]',16,1,'2023-06-29 17:10:23.221428');
INSERT INTO "django_admin_log" VALUES (195,'7','Omega semester 100 COE',1,'[{"added": {}}]',16,1,'2023-06-29 17:33:26.708577');
INSERT INTO "django_admin_log" VALUES (196,'5','400 Level COE',3,'',16,1,'2023-06-29 17:37:11.473090');
INSERT INTO "django_admin_log" VALUES (197,'4','300 Level coe',3,'',16,1,'2023-06-29 17:37:11.485227');
INSERT INTO "django_admin_log" VALUES (198,'3','100 Level COE',3,'',16,1,'2023-06-29 17:37:11.588635');
INSERT INTO "django_admin_log" VALUES (199,'2','200 Level COE',3,'',16,1,'2023-06-29 17:37:11.594597');
INSERT INTO "django_admin_log" VALUES (200,'8','GEC 112',1,'[{"added": {}}]',17,1,'2023-06-29 17:37:44.315300');
INSERT INTO "django_admin_log" VALUES (201,'8','TEST 1 GEC 112',1,'[{"added": {}}]',18,1,'2023-06-29 17:40:26.574464');
INSERT INTO "django_admin_log" VALUES (202,'8','GEC 112 TEST 1',2,'[{"changed": {"fields": ["Title"]}}]',18,1,'2023-06-29 17:48:40.808116');
INSERT INTO "django_admin_log" VALUES (203,'9','GEC 112 TEST 2',1,'[{"added": {}}]',18,1,'2023-06-29 17:49:02.279019');
INSERT INTO "django_admin_log" VALUES (204,'10','GEC 112 Examination',1,'[{"added": {}}]',18,1,'2023-06-29 17:49:23.987585');
INSERT INTO "django_admin_log" VALUES (205,'10','GEC 112 Test 11',2,'[{"changed": {"fields": ["Title"]}}]',18,1,'2023-06-29 17:49:39.032846');
INSERT INTO "django_admin_log" VALUES (206,'8','GEC 112 Examination',2,'[{"changed": {"fields": ["Title"]}}]',18,1,'2023-06-29 17:49:48.445605');
INSERT INTO "django_admin_log" VALUES (207,'10','GEC 112 Test 1',2,'[{"changed": {"fields": ["Title"]}}]',18,1,'2023-06-29 17:49:55.424269');
INSERT INTO "django_admin_log" VALUES (208,'d1879d5e-581a-45f3-b38c-2357f517ac5c','GEC 112 Test 1',1,'[{"added": {}}]',22,1,'2023-06-29 22:05:43.574885');
INSERT INTO "django_admin_log" VALUES (209,'3','Register ride',1,'[{"added": {}}]',12,1,'2023-07-19 12:46:39.467532');
INSERT INTO "django_admin_log" VALUES (210,'18','benson idahosa university UG',2,'[{"changed": {"fields": ["Category"]}}]',9,1,'2023-07-19 12:47:35.697889');
INSERT INTO "django_admin_log" VALUES (211,'2','PG',2,'[{"changed": {"fields": ["Approved"]}}]',12,1,'2023-07-19 12:48:52.029607');
INSERT INTO "django_admin_log" VALUES (212,'1','UG',2,'[{"changed": {"fields": ["Approved"]}}]',12,1,'2023-07-19 12:48:55.797869');
INSERT INTO "django_admin_log" VALUES (213,'17','Baze University UG',2,'[{"changed": {"fields": ["Category"]}}]',9,1,'2023-07-19 12:49:46.994185');
INSERT INTO "django_admin_log" VALUES (214,'16','bayero university UG',2,'[{"changed": {"fields": ["Category"]}}]',9,1,'2023-07-19 12:49:56.247568');
INSERT INTO "django_admin_log" VALUES (215,'15','Bakassi Technical University UG',2,'[{"changed": {"fields": ["Category"]}}]',9,1,'2023-07-19 12:50:06.137766');
INSERT INTO "django_admin_log" VALUES (216,'1','Gec 321',2,'[{"changed": {"fields": ["Pages", "Quizzes", "Assignments"]}}]',24,1,'2023-08-11 14:17:05.093659');
INSERT INTO "django_admin_log" VALUES (217,'9','Medicine Dosage',2,'[{"changed": {"fields": ["Title", "Points"]}}]',32,1,'2023-08-11 19:32:26.547093');
INSERT INTO "django_admin_log" VALUES (218,'8','Personal Health Vitals',2,'[{"changed": {"fields": ["Points"]}}]',32,1,'2023-08-11 19:32:35.714099');
INSERT INTO "django_admin_log" VALUES (219,'14','Dental Care',2,'[{"changed": {"fields": ["Title"]}}]',9,1,'2023-08-11 19:34:39.526186');
INSERT INTO "django_admin_log" VALUES (220,'6','Africa',1,'[{"added": {}}]',14,1,'2023-08-11 19:35:45.122318');
INSERT INTO "django_admin_log" VALUES (221,'14','Dental Carecxxc',2,'[{"changed": {"fields": ["Title"]}}]',9,1,'2023-08-11 19:37:04.238908');
INSERT INTO "django_admin_log" VALUES (222,'6','Africa',3,'',14,1,'2023-08-11 19:37:35.355579');
INSERT INTO "django_admin_log" VALUES (223,'1','Dental Care',2,'[{"changed": {"fields": ["Title"]}}]',9,1,'2023-08-11 19:41:12.734493');
INSERT INTO "django_admin_log" VALUES (224,'5','Africa',2,'[{"changed": {"fields": ["Title"]}}]',14,1,'2023-08-11 19:44:55.441886');
INSERT INTO "django_admin_log" VALUES (225,'5','Africa',2,'[{"changed": {"fields": ["Status"]}}]',14,1,'2023-08-11 19:45:42.224756');
INSERT INTO "django_admin_log" VALUES (226,'4','Asia',2,'[{"changed": {"fields": ["Title"]}}]',14,1,'2023-08-11 19:45:59.485590');
INSERT INTO "django_admin_log" VALUES (227,'3','Europe',2,'[{"changed": {"fields": ["Title"]}}]',14,1,'2023-08-11 19:46:10.191865');
INSERT INTO "django_admin_log" VALUES (228,'1','North-America',2,'[{"changed": {"fields": ["Title"]}}]',14,1,'2023-08-11 19:46:28.235726');
INSERT INTO "django_admin_log" VALUES (229,'7','South America',1,'[{"added": {}}]',14,1,'2023-08-11 19:47:00.001939');
INSERT INTO "django_admin_log" VALUES (230,'5','Africaa',2,'[{"changed": {"fields": ["Title"]}}]',14,1,'2023-08-11 19:50:59.138920');
INSERT INTO "django_admin_log" VALUES (231,'3','Africa',2,'[{"changed": {"fields": ["Title"]}}]',14,1,'2023-08-11 19:51:09.917451');
INSERT INTO "django_admin_log" VALUES (232,'5','Europe',2,'[{"changed": {"fields": ["Title"]}}]',14,1,'2023-08-11 19:51:21.434366');
INSERT INTO "django_admin_log" VALUES (233,'4','Nigeria',2,'[{"changed": {"fields": ["Title"]}}]',15,1,'2023-08-11 19:51:47.259655');
INSERT INTO "django_admin_log" VALUES (234,'9','Ghana',2,'[{"changed": {"fields": ["Title"]}}]',15,1,'2023-08-11 19:52:04.635722');
INSERT INTO "django_admin_log" VALUES (235,'8','Liberia',2,'[{"changed": {"fields": ["Title"]}}]',15,1,'2023-08-11 19:52:15.728201');
INSERT INTO "django_admin_log" VALUES (236,'7','Niger',2,'[{"changed": {"fields": ["Title"]}}]',15,1,'2023-08-11 19:52:24.104284');
INSERT INTO "django_admin_log" VALUES (237,'6','Botsana',2,'[{"changed": {"fields": ["Title"]}}]',15,1,'2023-08-11 19:52:32.310113');
INSERT INTO "django_admin_log" VALUES (238,'3','Chad',2,'[{"changed": {"fields": ["Title"]}}]',15,1,'2023-08-11 19:52:48.977624');
INSERT INTO "django_admin_log" VALUES (239,'4','Chads',2,'[{"changed": {"fields": ["Title"]}}]',15,1,'2023-08-11 19:53:51.767500');
INSERT INTO "django_admin_log" VALUES (240,'3','Nigeria',2,'[{"changed": {"fields": ["Title"]}}]',15,1,'2023-08-11 19:54:00.327864');
INSERT INTO "django_admin_log" VALUES (241,'4','Chad',2,'[{"changed": {"fields": ["Title"]}}]',15,1,'2023-08-11 19:54:07.808097');
INSERT INTO "django_admin_log" VALUES (242,'7','Abuja',2,'[{"changed": {"fields": ["Title"]}}]',16,1,'2023-08-11 19:54:54.118520');
INSERT INTO "django_admin_log" VALUES (243,'6','Lagos',2,'[{"changed": {"fields": ["Title"]}}]',16,1,'2023-08-11 19:55:04.228970');
INSERT INTO "django_admin_log" VALUES (244,'7','Abujaa',2,'[{"changed": {"fields": ["Title"]}}]',16,1,'2023-08-11 19:56:30.920911');
INSERT INTO "django_admin_log" VALUES (245,'6','Abuja',2,'[{"changed": {"fields": ["Title"]}}]',16,1,'2023-08-11 19:56:37.865695');
INSERT INTO "django_admin_log" VALUES (246,'7','Lagos',2,'[{"changed": {"fields": ["Title"]}}]',16,1,'2023-08-11 19:56:44.271407');
INSERT INTO "django_admin_log" VALUES (247,'8','AMAC',2,'[{"changed": {"fields": ["Title"]}}]',17,1,'2023-08-11 19:57:16.961969');
INSERT INTO "django_admin_log" VALUES (248,'10','Garki',2,'[{"changed": {"fields": ["Title"]}}]',18,1,'2023-08-11 20:00:17.427609');
INSERT INTO "django_admin_log" VALUES (249,'9','Wuse',2,'[{"changed": {"fields": ["Title"]}}]',18,1,'2023-08-11 20:00:28.751669');
INSERT INTO "django_admin_log" VALUES (250,'8','Utako',2,'[{"changed": {"fields": ["Title"]}}]',18,1,'2023-08-11 20:00:36.171461');
INSERT INTO "django_admin_log" VALUES (251,'d1879d5e-581a-45f3-b38c-2357f517ac5c','GEC 112 Test 1',2,'[]',22,1,'2023-08-11 20:05:54.331673');
INSERT INTO "django_admin_log" VALUES (252,'d1879d5e-581a-45f3-b38c-2357f517ac5c','Garki 1 branch',2,'[{"changed": {"fields": ["Title"]}}]',22,1,'2023-08-11 20:06:16.783425');
INSERT INTO "django_admin_log" VALUES (253,'1','Begin Location selection',2,'[{"changed": {"fields": ["Name"]}}]',12,1,'2023-08-11 20:08:41.905868');
INSERT INTO "django_admin_log" VALUES (254,'3','Register ride',2,'[{"changed": {"fields": ["Approved"]}}]',12,1,'2023-08-11 20:08:54.191562');
INSERT INTO "django_admin_log" VALUES (255,'1','Begin Location selection',2,'[{"changed": {"fields": ["Approved"]}}]',12,1,'2023-08-11 20:08:57.921471');
INSERT INTO "django_admin_log" VALUES (256,'1','Begin Virtual Location',2,'[{"changed": {"fields": ["Name"]}}]',12,1,'2023-08-11 20:10:10.115076');
INSERT INTO "django_admin_log" VALUES (257,'2','PG',3,'',12,1,'2023-08-11 20:10:16.453854');
INSERT INTO "django_admin_log" VALUES (258,'3','Register ride',3,'',12,1,'2023-08-11 20:10:20.389333');
INSERT INTO "django_admin_log" VALUES (259,'1','Let''s Begin',2,'[{"changed": {"fields": ["Name"]}}]',12,1,'2023-08-11 20:11:06.453874');
INSERT INTO "django_admin_log" VALUES (260,'7','Appointments',2,'[{"changed": {"fields": ["Points", "Files"]}}]',32,1,'2023-08-11 20:15:57.044948');
INSERT INTO "django_admin_log" VALUES (261,'1','Dr Isaac Olawale',2,'[{"changed": {"fields": ["Title"]}}]',24,1,'2023-08-11 20:19:12.689748');
INSERT INTO "django_admin_log" VALUES (262,'9','Dr_Isaac_Olawale',2,'[{"changed": {"fields": ["Username"]}}]',4,1,'2023-08-11 20:22:32.823324');
INSERT INTO "django_admin_log" VALUES (263,'14','Dental Carecxxc',2,'[{"changed": {"fields": ["Status"]}}]',9,1,'2023-08-12 09:44:30.388557');
INSERT INTO "django_admin_log" VALUES (264,'1','Dental Care',2,'[{"changed": {"fields": ["Image"]}}]',9,1,'2023-08-12 09:44:55.276801');
INSERT INTO "django_admin_log" VALUES (265,'7','cardiovascular',2,'[{"changed": {"fields": ["Title", "Image"]}}]',9,1,'2023-08-12 09:46:01.035849');
INSERT INTO "django_admin_log" VALUES (266,'8','neural system',2,'[{"changed": {"fields": ["Title", "Image"]}}]',9,1,'2023-08-12 09:47:09.582577');
INSERT INTO "django_admin_log" VALUES (267,'9','bones',2,'[{"changed": {"fields": ["Title", "Image"]}}]',9,1,'2023-08-12 09:48:39.549855');
INSERT INTO "django_admin_log" VALUES (268,'10','optical system',2,'[{"changed": {"fields": ["Title", "Image"]}}]',9,1,'2023-08-12 09:53:10.933245');
INSERT INTO "django_admin_log" VALUES (269,'11','nose system',2,'[{"changed": {"fields": ["Title", "Image"]}}]',9,1,'2023-08-12 09:54:15.440859');
INSERT INTO "django_admin_log" VALUES (270,'12','veins',2,'[{"changed": {"fields": ["Title"]}}]',9,1,'2023-08-12 09:54:36.030073');
INSERT INTO "django_admin_log" VALUES (271,'12','veins',2,'[{"changed": {"fields": ["Image"]}}]',9,1,'2023-08-12 09:55:09.413029');
INSERT INTO "django_admin_log" VALUES (272,'13','General',2,'[{"changed": {"fields": ["Title", "Image"]}}]',9,1,'2023-08-12 10:58:10.809275');
INSERT INTO "django_admin_log" VALUES (273,'d1879d5e-581a-45f3-b38c-2357f517ac5c','Garki 1 branch',2,'[{"changed": {"fields": ["Description", "Syllabus"]}}]',22,1,'2023-08-13 19:02:48.024749');
INSERT INTO "assignment_submission" VALUES (1,'user_3/banner_07.1.jpg','Jesus Loves you','2023-06-16 22:54:48.825878',4,3);
INSERT INTO "assignment_submission" VALUES (2,'user_5/IBTROS.png','Nice one sire','2023-06-16 23:00:27.576612',4,5);
INSERT INTO "assignment_submission" VALUES (3,'user_1/clearance_may_ssISLOI.pdf','hi','2023-08-11 14:04:58.417687',7,1);
INSERT INTO "assignment_submission" VALUES (4,'user_1/Copy_of_Personalized_Invites_for_IG.jpg','dd','2023-08-11 14:08:23.610491',7,1);
INSERT INTO "assignment_assignmentfilecontent" VALUES (1,'user_1/nysc.pdf',1);
INSERT INTO "assignment_assignmentfilecontent" VALUES (2,'user_1/banner_2.jpg',1);
INSERT INTO "assignment_assignmentfilecontent" VALUES (3,'user_1/IBTROS_rMrkGFZ.png',1);
INSERT INTO "assignment_assignmentfilecontent" VALUES (4,'user_1/bk_iHMrlXv.jpg',1);
INSERT INTO "assignment_assignmentfilecontent" VALUES (5,'user_1/team-4_iu73sf2.jpg',1);
INSERT INTO "assignment_assignmentfilecontent" VALUES (6,'user_1/Copy_of_Personalized_Invites_for_IG_1SPKOPX.jpg',1);
INSERT INTO "assignment_assignment_files" VALUES (1,1,1);
INSERT INTO "assignment_assignment_files" VALUES (2,3,2);
INSERT INTO "assignment_assignment_files" VALUES (3,5,3);
INSERT INTO "assignment_assignment_files" VALUES (4,6,4);
INSERT INTO "assignment_assignment_files" VALUES (5,8,5);
INSERT INTO "assignment_assignment_files" VALUES (6,9,6);
INSERT INTO "assignment_assignment_files" VALUES (7,7,1);
INSERT INTO "assignment_assignment" VALUES (1,'rrr','<p>e</p>',12,'2023-06-27',1);
INSERT INTO "assignment_assignment" VALUES (2,'Gender','wwwwwwww',4,'2023-06-27',1);
INSERT INTO "assignment_assignment" VALUES (3,'cars part 2','<p>Hello hello hello</p>',20,'2023-07-20',1);
INSERT INTO "assignment_assignment" VALUES (4,'eie_511_meeting','<p>hi</p>',10,'2023-06-21',1);
INSERT INTO "assignment_assignment" VALUES (5,'Dental test','<p>Hello</p>',10,'2023-08-31',1);
INSERT INTO "assignment_assignment" VALUES (6,'Eye','<p>as</p>',10,'2023-08-30',1);
INSERT INTO "assignment_assignment" VALUES (7,'Appointments','<p>This is the appointment form</p>

<p>&nbsp;</p>',1,'2023-08-31',1);
INSERT INTO "assignment_assignment" VALUES (8,'Personal Health Vitals','<p>This is a form for personal health vitals</p>',1,'2023-08-31',1);
INSERT INTO "assignment_assignment" VALUES (9,'Medicine Dosage','<p>This is the medicine dosage form</p>',1,'2023-08-31',1);
INSERT INTO "django_content_type" VALUES (1,'admin','logentry');
INSERT INTO "django_content_type" VALUES (2,'auth','permission');
INSERT INTO "django_content_type" VALUES (3,'auth','group');
INSERT INTO "django_content_type" VALUES (4,'auth','user');
INSERT INTO "django_content_type" VALUES (5,'contenttypes','contenttype');
INSERT INTO "django_content_type" VALUES (6,'sessions','session');
INSERT INTO "django_content_type" VALUES (7,'taggit','tag');
INSERT INTO "django_content_type" VALUES (8,'taggit','taggeditem');
INSERT INTO "django_content_type" VALUES (9,'blog','article');
INSERT INTO "django_content_type" VALUES (10,'blog','profile');
INSERT INTO "django_content_type" VALUES (11,'blog','comment');
INSERT INTO "django_content_type" VALUES (12,'blog','category');
INSERT INTO "django_content_type" VALUES (13,'blog','commentcourse');
INSERT INTO "django_content_type" VALUES (14,'blog','course');
INSERT INTO "django_content_type" VALUES (15,'blog','subject');
INSERT INTO "django_content_type" VALUES (16,'blog','room');
INSERT INTO "django_content_type" VALUES (17,'blog','rep');
INSERT INTO "django_content_type" VALUES (18,'blog','mem');
INSERT INTO "django_content_type" VALUES (19,'blog','table');
INSERT INTO "django_content_type" VALUES (20,'blog','chair');
INSERT INTO "django_content_type" VALUES (21,'authy','profile');
INSERT INTO "django_content_type" VALUES (22,'classroom','course');
INSERT INTO "django_content_type" VALUES (23,'classroom','grade');
INSERT INTO "django_content_type" VALUES (24,'module','module');
INSERT INTO "django_content_type" VALUES (25,'page','postfilecontent');
INSERT INTO "django_content_type" VALUES (26,'page','page');
INSERT INTO "django_content_type" VALUES (27,'quiz','answer');
INSERT INTO "django_content_type" VALUES (28,'quiz','question');
INSERT INTO "django_content_type" VALUES (29,'quiz','quizzes');
INSERT INTO "django_content_type" VALUES (30,'quiz','attempter');
INSERT INTO "django_content_type" VALUES (31,'quiz','attempt');
INSERT INTO "django_content_type" VALUES (32,'assignment','assignment');
INSERT INTO "django_content_type" VALUES (33,'assignment','submission');
INSERT INTO "django_content_type" VALUES (34,'assignment','assignmentfilecontent');
INSERT INTO "django_content_type" VALUES (35,'question','answer');
INSERT INTO "django_content_type" VALUES (36,'question','votes');
INSERT INTO "django_content_type" VALUES (37,'question','question');
INSERT INTO "django_content_type" VALUES (38,'completion','completion');
INSERT INTO "django_content_type" VALUES (39,'course','paidcourse');
INSERT INTO "django_content_type" VALUES (40,'course','priceplan');
INSERT INTO "django_content_type" VALUES (41,'direct','message');
INSERT INTO "django_content_type" VALUES (42,'lms','contact');
INSERT INTO "django_content_type" VALUES (43,'blog','click');
INSERT INTO "django_content_type" VALUES (44,'direct','livestream');
INSERT INTO "django_content_type" VALUES (45,'livestream','livestream');
INSERT INTO "auth_permission" VALUES (1,1,'add_logentry','Can add log entry');
INSERT INTO "auth_permission" VALUES (2,1,'change_logentry','Can change log entry');
INSERT INTO "auth_permission" VALUES (3,1,'delete_logentry','Can delete log entry');
INSERT INTO "auth_permission" VALUES (4,1,'view_logentry','Can view log entry');
INSERT INTO "auth_permission" VALUES (5,2,'add_permission','Can add permission');
INSERT INTO "auth_permission" VALUES (6,2,'change_permission','Can change permission');
INSERT INTO "auth_permission" VALUES (7,2,'delete_permission','Can delete permission');
INSERT INTO "auth_permission" VALUES (8,2,'view_permission','Can view permission');
INSERT INTO "auth_permission" VALUES (9,3,'add_group','Can add group');
INSERT INTO "auth_permission" VALUES (10,3,'change_group','Can change group');
INSERT INTO "auth_permission" VALUES (11,3,'delete_group','Can delete group');
INSERT INTO "auth_permission" VALUES (12,3,'view_group','Can view group');
INSERT INTO "auth_permission" VALUES (13,4,'add_user','Can add user');
INSERT INTO "auth_permission" VALUES (14,4,'change_user','Can change user');
INSERT INTO "auth_permission" VALUES (15,4,'delete_user','Can delete user');
INSERT INTO "auth_permission" VALUES (16,4,'view_user','Can view user');
INSERT INTO "auth_permission" VALUES (17,5,'add_contenttype','Can add content type');
INSERT INTO "auth_permission" VALUES (18,5,'change_contenttype','Can change content type');
INSERT INTO "auth_permission" VALUES (19,5,'delete_contenttype','Can delete content type');
INSERT INTO "auth_permission" VALUES (20,5,'view_contenttype','Can view content type');
INSERT INTO "auth_permission" VALUES (21,6,'add_session','Can add session');
INSERT INTO "auth_permission" VALUES (22,6,'change_session','Can change session');
INSERT INTO "auth_permission" VALUES (23,6,'delete_session','Can delete session');
INSERT INTO "auth_permission" VALUES (24,6,'view_session','Can view session');
INSERT INTO "auth_permission" VALUES (25,7,'add_tag','Can add tag');
INSERT INTO "auth_permission" VALUES (26,7,'change_tag','Can change tag');
INSERT INTO "auth_permission" VALUES (27,7,'delete_tag','Can delete tag');
INSERT INTO "auth_permission" VALUES (28,7,'view_tag','Can view tag');
INSERT INTO "auth_permission" VALUES (29,8,'add_taggeditem','Can add tagged item');
INSERT INTO "auth_permission" VALUES (30,8,'change_taggeditem','Can change tagged item');
INSERT INTO "auth_permission" VALUES (31,8,'delete_taggeditem','Can delete tagged item');
INSERT INTO "auth_permission" VALUES (32,8,'view_taggeditem','Can view tagged item');
INSERT INTO "auth_permission" VALUES (33,9,'add_article','Can add article');
INSERT INTO "auth_permission" VALUES (34,9,'change_article','Can change article');
INSERT INTO "auth_permission" VALUES (35,9,'delete_article','Can delete article');
INSERT INTO "auth_permission" VALUES (36,9,'view_article','Can view article');
INSERT INTO "auth_permission" VALUES (37,10,'add_profile','Can add profile');
INSERT INTO "auth_permission" VALUES (38,10,'change_profile','Can change profile');
INSERT INTO "auth_permission" VALUES (39,10,'delete_profile','Can delete profile');
INSERT INTO "auth_permission" VALUES (40,10,'view_profile','Can view profile');
INSERT INTO "auth_permission" VALUES (41,11,'add_comment','Can add comment');
INSERT INTO "auth_permission" VALUES (42,11,'change_comment','Can change comment');
INSERT INTO "auth_permission" VALUES (43,11,'delete_comment','Can delete comment');
INSERT INTO "auth_permission" VALUES (44,11,'view_comment','Can view comment');
INSERT INTO "auth_permission" VALUES (45,12,'add_category','Can add category');
INSERT INTO "auth_permission" VALUES (46,12,'change_category','Can change category');
INSERT INTO "auth_permission" VALUES (47,12,'delete_category','Can delete category');
INSERT INTO "auth_permission" VALUES (48,12,'view_category','Can view category');
INSERT INTO "auth_permission" VALUES (49,13,'add_commentcourse','Can add comment course');
INSERT INTO "auth_permission" VALUES (50,13,'change_commentcourse','Can change comment course');
INSERT INTO "auth_permission" VALUES (51,13,'delete_commentcourse','Can delete comment course');
INSERT INTO "auth_permission" VALUES (52,13,'view_commentcourse','Can view comment course');
INSERT INTO "auth_permission" VALUES (53,14,'add_course','Can add course');
INSERT INTO "auth_permission" VALUES (54,14,'change_course','Can change course');
INSERT INTO "auth_permission" VALUES (55,14,'delete_course','Can delete course');
INSERT INTO "auth_permission" VALUES (56,14,'view_course','Can view course');
INSERT INTO "auth_permission" VALUES (57,15,'add_subject','Can add subject');
INSERT INTO "auth_permission" VALUES (58,15,'change_subject','Can change subject');
INSERT INTO "auth_permission" VALUES (59,15,'delete_subject','Can delete subject');
INSERT INTO "auth_permission" VALUES (60,15,'view_subject','Can view subject');
INSERT INTO "auth_permission" VALUES (61,16,'add_room','Can add room');
INSERT INTO "auth_permission" VALUES (62,16,'change_room','Can change room');
INSERT INTO "auth_permission" VALUES (63,16,'delete_room','Can delete room');
INSERT INTO "auth_permission" VALUES (64,16,'view_room','Can view room');
INSERT INTO "auth_permission" VALUES (65,17,'add_rep','Can add rep');
INSERT INTO "auth_permission" VALUES (66,17,'change_rep','Can change rep');
INSERT INTO "auth_permission" VALUES (67,17,'delete_rep','Can delete rep');
INSERT INTO "auth_permission" VALUES (68,17,'view_rep','Can view rep');
INSERT INTO "auth_permission" VALUES (69,18,'add_mem','Can add mem');
INSERT INTO "auth_permission" VALUES (70,18,'change_mem','Can change mem');
INSERT INTO "auth_permission" VALUES (71,18,'delete_mem','Can delete mem');
INSERT INTO "auth_permission" VALUES (72,18,'view_mem','Can view mem');
INSERT INTO "auth_permission" VALUES (73,19,'add_table','Can add table');
INSERT INTO "auth_permission" VALUES (74,19,'change_table','Can change table');
INSERT INTO "auth_permission" VALUES (75,19,'delete_table','Can delete table');
INSERT INTO "auth_permission" VALUES (76,19,'view_table','Can view table');
INSERT INTO "auth_permission" VALUES (77,20,'add_chair','Can add chair');
INSERT INTO "auth_permission" VALUES (78,20,'change_chair','Can change chair');
INSERT INTO "auth_permission" VALUES (79,20,'delete_chair','Can delete chair');
INSERT INTO "auth_permission" VALUES (80,20,'view_chair','Can view chair');
INSERT INTO "auth_permission" VALUES (81,21,'add_profile','Can add profile');
INSERT INTO "auth_permission" VALUES (82,21,'change_profile','Can change profile');
INSERT INTO "auth_permission" VALUES (83,21,'delete_profile','Can delete profile');
INSERT INTO "auth_permission" VALUES (84,21,'view_profile','Can view profile');
INSERT INTO "auth_permission" VALUES (85,22,'add_course','Can add course');
INSERT INTO "auth_permission" VALUES (86,22,'change_course','Can change course');
INSERT INTO "auth_permission" VALUES (87,22,'delete_course','Can delete course');
INSERT INTO "auth_permission" VALUES (88,22,'view_course','Can view course');
INSERT INTO "auth_permission" VALUES (89,23,'add_grade','Can add grade');
INSERT INTO "auth_permission" VALUES (90,23,'change_grade','Can change grade');
INSERT INTO "auth_permission" VALUES (91,23,'delete_grade','Can delete grade');
INSERT INTO "auth_permission" VALUES (92,23,'view_grade','Can view grade');
INSERT INTO "auth_permission" VALUES (93,24,'add_module','Can add module');
INSERT INTO "auth_permission" VALUES (94,24,'change_module','Can change module');
INSERT INTO "auth_permission" VALUES (95,24,'delete_module','Can delete module');
INSERT INTO "auth_permission" VALUES (96,24,'view_module','Can view module');
INSERT INTO "auth_permission" VALUES (97,25,'add_postfilecontent','Can add post file content');
INSERT INTO "auth_permission" VALUES (98,25,'change_postfilecontent','Can change post file content');
INSERT INTO "auth_permission" VALUES (99,25,'delete_postfilecontent','Can delete post file content');
INSERT INTO "auth_permission" VALUES (100,25,'view_postfilecontent','Can view post file content');
INSERT INTO "auth_permission" VALUES (101,26,'add_page','Can add page');
INSERT INTO "auth_permission" VALUES (102,26,'change_page','Can change page');
INSERT INTO "auth_permission" VALUES (103,26,'delete_page','Can delete page');
INSERT INTO "auth_permission" VALUES (104,26,'view_page','Can view page');
INSERT INTO "auth_permission" VALUES (105,27,'add_answer','Can add answer');
INSERT INTO "auth_permission" VALUES (106,27,'change_answer','Can change answer');
INSERT INTO "auth_permission" VALUES (107,27,'delete_answer','Can delete answer');
INSERT INTO "auth_permission" VALUES (108,27,'view_answer','Can view answer');
INSERT INTO "auth_permission" VALUES (109,28,'add_question','Can add question');
INSERT INTO "auth_permission" VALUES (110,28,'change_question','Can change question');
INSERT INTO "auth_permission" VALUES (111,28,'delete_question','Can delete question');
INSERT INTO "auth_permission" VALUES (112,28,'view_question','Can view question');
INSERT INTO "auth_permission" VALUES (113,29,'add_quizzes','Can add quizzes');
INSERT INTO "auth_permission" VALUES (114,29,'change_quizzes','Can change quizzes');
INSERT INTO "auth_permission" VALUES (115,29,'delete_quizzes','Can delete quizzes');
INSERT INTO "auth_permission" VALUES (116,29,'view_quizzes','Can view quizzes');
INSERT INTO "auth_permission" VALUES (117,30,'add_attempter','Can add attempter');
INSERT INTO "auth_permission" VALUES (118,30,'change_attempter','Can change attempter');
INSERT INTO "auth_permission" VALUES (119,30,'delete_attempter','Can delete attempter');
INSERT INTO "auth_permission" VALUES (120,30,'view_attempter','Can view attempter');
INSERT INTO "auth_permission" VALUES (121,31,'add_attempt','Can add attempt');
INSERT INTO "auth_permission" VALUES (122,31,'change_attempt','Can change attempt');
INSERT INTO "auth_permission" VALUES (123,31,'delete_attempt','Can delete attempt');
INSERT INTO "auth_permission" VALUES (124,31,'view_attempt','Can view attempt');
INSERT INTO "auth_permission" VALUES (125,32,'add_assignment','Can add assignment');
INSERT INTO "auth_permission" VALUES (126,32,'change_assignment','Can change assignment');
INSERT INTO "auth_permission" VALUES (127,32,'delete_assignment','Can delete assignment');
INSERT INTO "auth_permission" VALUES (128,32,'view_assignment','Can view assignment');
INSERT INTO "auth_permission" VALUES (129,33,'add_submission','Can add submission');
INSERT INTO "auth_permission" VALUES (130,33,'change_submission','Can change submission');
INSERT INTO "auth_permission" VALUES (131,33,'delete_submission','Can delete submission');
INSERT INTO "auth_permission" VALUES (132,33,'view_submission','Can view submission');
INSERT INTO "auth_permission" VALUES (133,34,'add_assignmentfilecontent','Can add assignment file content');
INSERT INTO "auth_permission" VALUES (134,34,'change_assignmentfilecontent','Can change assignment file content');
INSERT INTO "auth_permission" VALUES (135,34,'delete_assignmentfilecontent','Can delete assignment file content');
INSERT INTO "auth_permission" VALUES (136,34,'view_assignmentfilecontent','Can view assignment file content');
INSERT INTO "auth_permission" VALUES (137,35,'add_answer','Can add answer');
INSERT INTO "auth_permission" VALUES (138,35,'change_answer','Can change answer');
INSERT INTO "auth_permission" VALUES (139,35,'delete_answer','Can delete answer');
INSERT INTO "auth_permission" VALUES (140,35,'view_answer','Can view answer');
INSERT INTO "auth_permission" VALUES (141,36,'add_votes','Can add votes');
INSERT INTO "auth_permission" VALUES (142,36,'change_votes','Can change votes');
INSERT INTO "auth_permission" VALUES (143,36,'delete_votes','Can delete votes');
INSERT INTO "auth_permission" VALUES (144,36,'view_votes','Can view votes');
INSERT INTO "auth_permission" VALUES (145,37,'add_question','Can add question');
INSERT INTO "auth_permission" VALUES (146,37,'change_question','Can change question');
INSERT INTO "auth_permission" VALUES (147,37,'delete_question','Can delete question');
INSERT INTO "auth_permission" VALUES (148,37,'view_question','Can view question');
INSERT INTO "auth_permission" VALUES (149,38,'add_completion','Can add completion');
INSERT INTO "auth_permission" VALUES (150,38,'change_completion','Can change completion');
INSERT INTO "auth_permission" VALUES (151,38,'delete_completion','Can delete completion');
INSERT INTO "auth_permission" VALUES (152,38,'view_completion','Can view completion');
INSERT INTO "auth_permission" VALUES (153,39,'add_paidcourse','Can add paid course');
INSERT INTO "auth_permission" VALUES (154,39,'change_paidcourse','Can change paid course');
INSERT INTO "auth_permission" VALUES (155,39,'delete_paidcourse','Can delete paid course');
INSERT INTO "auth_permission" VALUES (156,39,'view_paidcourse','Can view paid course');
INSERT INTO "auth_permission" VALUES (157,40,'add_priceplan','Can add price plan');
INSERT INTO "auth_permission" VALUES (158,40,'change_priceplan','Can change price plan');
INSERT INTO "auth_permission" VALUES (159,40,'delete_priceplan','Can delete price plan');
INSERT INTO "auth_permission" VALUES (160,40,'view_priceplan','Can view price plan');
INSERT INTO "auth_permission" VALUES (161,41,'add_message','Can add message');
INSERT INTO "auth_permission" VALUES (162,41,'change_message','Can change message');
INSERT INTO "auth_permission" VALUES (163,41,'delete_message','Can delete message');
INSERT INTO "auth_permission" VALUES (164,41,'view_message','Can view message');
INSERT INTO "auth_permission" VALUES (165,42,'add_contact','Can add contact');
INSERT INTO "auth_permission" VALUES (166,42,'change_contact','Can change contact');
INSERT INTO "auth_permission" VALUES (167,42,'delete_contact','Can delete contact');
INSERT INTO "auth_permission" VALUES (168,42,'view_contact','Can view contact');
INSERT INTO "auth_permission" VALUES (169,43,'add_click','Can add click');
INSERT INTO "auth_permission" VALUES (170,43,'change_click','Can change click');
INSERT INTO "auth_permission" VALUES (171,43,'delete_click','Can delete click');
INSERT INTO "auth_permission" VALUES (172,43,'view_click','Can view click');
INSERT INTO "auth_permission" VALUES (173,44,'add_livestream','Can add livestream');
INSERT INTO "auth_permission" VALUES (174,44,'change_livestream','Can change livestream');
INSERT INTO "auth_permission" VALUES (175,44,'delete_livestream','Can delete livestream');
INSERT INTO "auth_permission" VALUES (176,44,'view_livestream','Can view livestream');
INSERT INTO "auth_permission" VALUES (177,45,'add_livestream','Can add livestream');
INSERT INTO "auth_permission" VALUES (178,45,'change_livestream','Can change livestream');
INSERT INTO "auth_permission" VALUES (179,45,'delete_livestream','Can delete livestream');
INSERT INTO "auth_permission" VALUES (180,45,'view_livestream','Can view livestream');
INSERT INTO "auth_user" VALUES (1,'pbkdf2_sha256$600000$1SHOvd6vVy81axk2dR6hGs$DqfrHeIyaIRGJhhS+mcsVa7V6+x//cxiyWg/fEEA1Hs=','2023-08-13 18:07:06.009250',1,'admin','','admin@gmail.com',1,1,'2023-06-10 15:56:24.969409','');
INSERT INTO "auth_user" VALUES (2,'pbkdf2_sha256$600000$hnTFUpsdkhWyGMPcSuRg3s$RYCDHJjbr7wMtvTCxs7FXrVJ6b528WeOYUTgLhh3tBQ=',NULL,1,'main','','main@gmail.com',1,1,'2023-06-11 16:11:08.396244','');
INSERT INTO "auth_user" VALUES (3,'pbkdf2_sha256$600000$QpvK8TlKRRvhkjW4rNkCe0$1pY+Z+XzhCBUNqy0RAyrZahGqXb8Jx+wWkkCrsfDk9U=','2023-08-11 13:29:25.216879',1,'clear','','clear@gmail.com',1,1,'2023-06-11 16:13:43.364088','');
INSERT INTO "auth_user" VALUES (4,'pbkdf2_sha256$600000$SyXgDmbhnBkhsdlFMwXoKD$rOok10wRH0JSryfooLnQwPFbfB8aeDQlvIhkom88KME=',NULL,0,'Oluwasyi','','',0,1,'2023-06-11 16:14:20.839959','');
INSERT INTO "auth_user" VALUES (5,'pbkdf2_sha256$600000$QGkFbpIr8EK0V1WjjU0Yln$O5jvRHdxvzE6kIZxZSuPIDwYK97Yb8uDSxLP5892ngo=','2023-06-29 19:27:30.366127',0,'Peter','','peter@gmail.com',0,1,'2023-06-16 08:56:16.907244','');
INSERT INTO "auth_user" VALUES (6,'pbkdf2_sha256$600000$B1qr6kVlnSLNW5ABNk6gw0$S3AMhbPlS070ew6yAuE+eCPw/6ruVHJM4cgUw2J/kl8=','2023-06-16 19:15:07.457876',0,'victor','','victor@gmail.com',0,1,'2023-06-16 19:14:50.456469','');
INSERT INTO "auth_user" VALUES (7,'pbkdf2_sha256$600000$eh7mZ2OvRY1amFx9BObEBW$iIMkmIrhZqJM11XIXc6iuEOfEMz7oa5pxUtLsgzuFhc=',NULL,0,'ope','','opejeremiah@gmail.com',0,1,'2023-06-27 19:31:24.790594','');
INSERT INTO "auth_user" VALUES (8,'pbkdf2_sha256$600000$CzzceXqNVnlYBfBqUgPGgb$2j6a3QrBkZG8cO3ZWMJlJl/YF0oRyvoUTm7a5xG6X8k=',NULL,0,'ope_jeremiah','','jere@gmail.com',0,1,'2023-06-27 19:35:30.574962','');
INSERT INTO "auth_user" VALUES (9,'pbkdf2_sha256$600000$MEmoT9RmO6P47NGt8nsHCX$n6F3PIgefbva0sj4m0p5Ekpv82EZyMsSxCorjau4fHw=','2023-06-30 11:31:41',0,'Dr_Isaac_Olawale','','James@gmail.com',0,1,'2023-06-30 11:31:30','');
INSERT INTO "auth_user" VALUES (10,'pbkdf2_sha256$600000$kMHUMsuNkyFxwnAe0ax5Rh$JNh01X+JR1DvKUXmi4MoKA9H9MMQp/DWIpSisSnPKxk=','2023-08-11 19:28:10.041702',0,'Joseph','','johndoe@example.com',0,1,'2023-08-11 19:27:58.913425','');
INSERT INTO "blog_article" VALUES (1,'Dental Care','dental-care','article_pics/tooth.png','Jesus Christ','<p>Hi</p>','2023-06-10 16:15:43','2023-06-10 16:16:18.870578','2023-08-12 09:44:55.263434','PUBLISHED',0,'1','1',0,1,1);
INSERT INTO "blog_article" VALUES (7,'cardiovascular','cardiovascular','article_pics/daily-health-app.png',NULL,'','2023-06-29 16:23:57','2023-06-29 16:24:38.128692','2023-08-12 09:46:01.006720','PUBLISHED',0,'0','0',0,1,1);
INSERT INTO "blog_article" VALUES (8,'neural system','neural-system','article_pics/brain.png',NULL,'','2023-06-29 16:25:23','2023-06-29 16:25:53.461669','2023-08-12 09:47:09.188394','PUBLISHED',0,'0','0',0,1,1);
INSERT INTO "blog_article" VALUES (9,'bones','bones','article_pics/knee.png',NULL,'','2023-06-29 16:26:47','2023-06-29 16:27:16.619897','2023-08-12 09:48:39.363815','PUBLISHED',0,'0','0',0,1,1);
INSERT INTO "blog_article" VALUES (10,'optical system','optical-system','article_pics/eye.png',NULL,'','2023-06-29 16:29:00','2023-06-29 16:29:36.217509','2023-08-12 09:53:10.917044','PUBLISHED',0,'0','0',0,1,1);
INSERT INTO "blog_article" VALUES (11,'nose system','nose-system','article_pics/nose.png',NULL,'','2023-06-29 16:30:13','2023-06-29 16:30:47.897782','2023-08-12 09:54:15.425567','PUBLISHED',0,'0','0',0,1,1);
INSERT INTO "blog_article" VALUES (12,'veins','veins','article_pics/veins.png',NULL,'','2023-06-29 16:30:49','2023-06-29 16:31:27.270584','2023-08-12 09:55:09.400254','PUBLISHED',0,'0','0',0,1,1);
INSERT INTO "blog_article" VALUES (13,'General','general','article_pics/doctor.png',NULL,'','2023-06-29 16:31:37','2023-06-29 16:32:43.033118','2023-08-12 10:58:10.807281','PUBLISHED',0,'0','0',0,1,1);
INSERT INTO "blog_article" VALUES (14,'Dental Carecxxc','dental-carecxxc','article_pics/Babcock_university.jpg',NULL,'','2023-06-29 16:33:13','2023-06-29 16:33:38.505181','2023-08-12 09:44:30.382281','DRAFTED',0,'0','0',0,1,1);
INSERT INTO "blog_category" VALUES (1,'Let''s Begin','lets-begin','category_images/dot_iDBveI9_aFXONk9.png',1,'2023-06-10 16:11:24.742404','2023-08-11 20:11:06.419854');
INSERT INTO "blog_course" VALUES (1,'North-America','north-america','course_pics/dot_iDBveI9_rQUzBvx.png','Jesus Christ','<p>y</p>','2023-06-10 17:14:12','2023-06-10 17:14:34.120239','2023-08-11 19:46:28.211602','PUBLISHED',0,'1','1',0,1,1);
INSERT INTO "blog_course" VALUES (3,'Africa','africa','course_pics/dot.png',NULL,'','2023-06-23 13:30:53','2023-06-23 13:31:15.158814','2023-08-11 19:51:09.914487','PUBLISHED',0,'0','0',0,1,1);
INSERT INTO "blog_course" VALUES (4,'Asia','asia','course-default.jpg',NULL,'','2023-06-29 15:30:08','2023-06-29 15:30:24.163718','2023-08-11 19:45:59.381965','PUBLISHED',0,'0','0',0,1,1);
INSERT INTO "blog_course" VALUES (5,'Europe','europe','course-default.jpg','1','','2023-06-29 15:30:30','2023-06-29 15:30:51.040506','2023-08-11 19:51:21.426390','PUBLISHED',0,'0','0',0,1,1);
INSERT INTO "blog_course" VALUES (7,'South America','south-america','course-default.jpg',NULL,'','2023-08-11 19:46:37','2023-08-11 19:46:59.862230','2023-08-11 19:46:59.862230','PUBLISHED',0,'0','0',0,1,1);
INSERT INTO "blog_subject" VALUES (3,'Nigeria','nigeria','subject_pics/dot_iDBveI9.png',NULL,'','2023-06-23 13:52:45','2023-06-23 13:53:38.451935','2023-08-11 19:54:00.322903','PUBLISHED',0,'0','0',0,1,3);
INSERT INTO "blog_subject" VALUES (4,'Chad','chad','subject-default.jpg',NULL,'','2023-06-26 14:21:20','2023-06-26 14:21:39.081335','2023-08-11 19:54:06.838232','DRAFTED',0,'0','0',0,1,3);
INSERT INTO "blog_subject" VALUES (6,'Botsana','botsana','subject-default.jpg',NULL,'','2023-06-29 17:03:41','2023-06-29 17:03:53.052949','2023-08-11 19:52:32.306136','PUBLISHED',0,'0','0',0,1,3);
INSERT INTO "blog_subject" VALUES (7,'Niger','niger','subject-default.jpg',NULL,'','2023-06-29 17:03:56','2023-06-29 17:04:07.196037','2023-08-11 19:52:23.920646','PUBLISHED',0,'0','0',0,1,3);
INSERT INTO "blog_subject" VALUES (8,'Liberia','liberia','subject-default.jpg',NULL,'','2023-06-29 17:04:09','2023-06-29 17:04:23.811739','2023-08-11 19:52:15.682888','PUBLISHED',0,'0','0',0,1,3);
INSERT INTO "blog_subject" VALUES (9,'Ghana','ghana','subject-default.jpg',NULL,'','2023-06-29 17:04:50','2023-06-29 17:05:04.298375','2023-08-11 19:52:04.604805','PUBLISHED',0,'0','0',0,1,3);
INSERT INTO "blog_room" VALUES (6,'Abuja','abuja','rooms-default.jpg',NULL,'','2023-06-29 15:42:58','2023-06-29 15:43:14.315208','2023-08-11 19:56:37.860708','PUBLISHED',0,'0','0',0,1,3);
INSERT INTO "blog_room" VALUES (7,'Lagos','lagos','rooms-default.jpg',NULL,'','2023-06-29 17:32:59','2023-06-29 17:33:26.698863','2023-08-11 19:56:44.266420','PUBLISHED',0,'0','0',0,1,3);
INSERT INTO "blog_rep" VALUES (8,'AMAC','amac','rep-default.jpg',NULL,'','2023-06-29 17:37:24','2023-06-29 17:37:44.304061','2023-08-11 19:57:16.602439','PUBLISHED',0,'0','0',0,1,6);
INSERT INTO "blog_mem" VALUES (8,'Utako','utako','mem-default.jpg',NULL,'','2023-06-29 17:39:52','2023-06-29 17:40:26.559307','2023-08-11 20:00:36.167470','PUBLISHED',0,'0','0',0,1,8);
INSERT INTO "blog_mem" VALUES (9,'Wuse','wuse','mem-default.jpg',NULL,'','2023-06-29 17:48:48','2023-06-29 17:49:02.274009','2023-08-11 20:00:28.751669','PUBLISHED',0,'0','0',0,1,8);
INSERT INTO "blog_mem" VALUES (10,'Garki','garki','mem-default.jpg',NULL,'','2023-06-29 17:49:09','2023-06-29 17:49:23.984856','2023-08-11 20:00:17.423621','PUBLISHED',0,'0','0',0,1,8);
INSERT INTO "question_question" VALUES (1,'Thanks giving question','<p>Bawo ni</p>','2023-06-12 08:01:34.742320','2023-06-12 08:01:34.742320',0,1);
INSERT INTO "question_question" VALUES (2,'GEC','<p>How did you get equation one</p>','2023-06-27 17:53:58.016703','2023-06-27 17:53:58.016703',0,1);
INSERT INTO "question_question" VALUES (3,'Hi','<p>ynnnn</p>','2023-08-11 13:41:00.724871','2023-08-11 13:41:00.724871',0,1);
INSERT INTO "question_answer" VALUES (1,'ynnn','2023-06-12 08:54:56.735220','2023-06-12 08:54:56.735220',0,0,1,1);
INSERT INTO "quiz_answer" VALUES (1,'God kind of Love',1,1);
INSERT INTO "quiz_answer" VALUES (2,'pray',0,1);
INSERT INTO "quiz_answer" VALUES (3,'pray',1,1);
INSERT INTO "quiz_answer" VALUES (4,'pray',1,1);
INSERT INTO "quiz_answer" VALUES (5,'God kind of Love',1,1);
INSERT INTO "quiz_answer" VALUES (6,'y w.r.t to x',1,1);
INSERT INTO "quiz_answer" VALUES (7,'dy divided by dx plus 2',0,1);
INSERT INTO "quiz_answer" VALUES (8,'all of the above',0,1);
INSERT INTO "quiz_answer" VALUES (9,'The application of sciencef',1,1);
INSERT INTO "quiz_answer" VALUES (10,'sleeping and doing nothing always',0,1);
INSERT INTO "quiz_question" VALUES (1,'what is the meaning of john 3:16',2,1);
INSERT INTO "quiz_question" VALUES (2,'what is the meaning of engineering',3,1);
INSERT INTO "quiz_question" VALUES (3,'what does dy/dx mean',1,1);
INSERT INTO "quiz_question_answers" VALUES (1,1,1);
INSERT INTO "quiz_question_answers" VALUES (6,3,8);
INSERT INTO "quiz_question_answers" VALUES (7,3,6);
INSERT INTO "quiz_question_answers" VALUES (8,3,7);
INSERT INTO "quiz_question_answers" VALUES (9,2,8);
INSERT INTO "quiz_question_answers" VALUES (10,2,9);
INSERT INTO "quiz_question_answers" VALUES (11,2,10);
INSERT INTO "quiz_quizzes_questions" VALUES (1,1,1);
INSERT INTO "quiz_quizzes_questions" VALUES (2,2,2);
INSERT INTO "quiz_quizzes_questions" VALUES (7,4,2);
INSERT INTO "quiz_quizzes_questions" VALUES (8,4,3);
INSERT INTO "quiz_attempter" VALUES (1,2,'2023-06-13 09:43:54.648286',1,1);
INSERT INTO "quiz_attempter" VALUES (2,2,'2023-06-13 09:50:23.233414',1,1);
INSERT INTO "quiz_attempter" VALUES (3,2,'2023-06-14 08:43:46.235216',1,1);
INSERT INTO "quiz_attempter" VALUES (4,3,'2023-06-14 08:59:01.345985',2,3);
INSERT INTO "quiz_attempter" VALUES (5,2,'2023-06-16 15:12:19.687211',1,3);
INSERT INTO "quiz_attempter" VALUES (6,7,'2023-06-17 13:59:13.391242',4,1);
INSERT INTO "quiz_attempter" VALUES (7,7,'2023-06-17 13:59:40.172802',4,1);
INSERT INTO "quiz_attempter" VALUES (8,7,'2023-06-17 14:01:37.828028',4,1);
INSERT INTO "quiz_attempter" VALUES (9,7,'2023-06-17 14:05:25.235771',4,1);
INSERT INTO "quiz_attempter" VALUES (10,0,'2023-06-17 14:09:38.141028',4,1);
INSERT INTO "quiz_attempter" VALUES (11,7,'2023-06-17 14:09:56.016375',4,1);
INSERT INTO "quiz_attempter" VALUES (12,3,'2023-06-17 14:59:58.232867',2,1);
INSERT INTO "quiz_attempter" VALUES (13,7,'2023-06-23 16:59:49.190115',4,1);
INSERT INTO "quiz_attempter" VALUES (14,2,'2023-06-23 17:00:07.678444',4,1);
INSERT INTO "quiz_attempter" VALUES (15,7,'2023-06-24 08:31:45.593350',4,5);
INSERT INTO "quiz_attempter" VALUES (16,0,'2023-06-24 09:08:04.120892',4,1);
INSERT INTO "quiz_attempter" VALUES (17,0,'2023-06-24 09:08:29.316161',4,1);
INSERT INTO "quiz_attempter" VALUES (18,0,'2023-06-24 09:08:33.416694',4,1);
INSERT INTO "quiz_attempter" VALUES (19,0,'2023-06-24 09:08:37.031377',4,1);
INSERT INTO "quiz_attempter" VALUES (20,0,'2023-06-24 09:11:30.510210',4,1);
INSERT INTO "quiz_attempter" VALUES (21,0,'2023-06-24 09:12:22.832861',4,1);
INSERT INTO "quiz_attempter" VALUES (22,0,'2023-06-24 09:16:06.781659',4,1);
INSERT INTO "quiz_attempter" VALUES (23,0,'2023-06-24 09:22:40.128082',4,1);
INSERT INTO "quiz_attempter" VALUES (24,0,'2023-06-24 09:22:44.677056',4,1);
INSERT INTO "quiz_attempter" VALUES (25,0,'2023-06-24 10:14:26.073470',4,1);
INSERT INTO "quiz_attempter" VALUES (26,7,'2023-06-24 13:54:49.882061',4,1);
INSERT INTO "quiz_attempter" VALUES (27,7,'2023-06-24 14:04:00.894213',4,1);
INSERT INTO "quiz_attempter" VALUES (28,3,'2023-06-24 14:30:01.869249',4,1);
INSERT INTO "quiz_attempter" VALUES (29,0,'2023-06-24 14:44:53.295114',4,1);
INSERT INTO "quiz_attempter" VALUES (30,1,'2023-06-24 15:02:29.919736',4,1);
INSERT INTO "quiz_attempter" VALUES (31,1,'2023-06-24 15:02:30.725484',4,1);
INSERT INTO "quiz_attempter" VALUES (32,1,'2023-06-24 15:02:31.049084',4,1);
INSERT INTO "quiz_attempter" VALUES (33,1,'2023-06-24 15:02:31.053549',4,1);
INSERT INTO "quiz_attempter" VALUES (34,1,'2023-06-24 15:02:31.642285',4,1);
INSERT INTO "quiz_attempter" VALUES (35,1,'2023-06-24 15:02:32.099286',4,1);
INSERT INTO "quiz_attempter" VALUES (36,1,'2023-06-24 15:02:32.515410',4,1);
INSERT INTO "quiz_attempter" VALUES (37,1,'2023-06-24 15:02:33.086615',4,1);
INSERT INTO "quiz_attempter" VALUES (38,1,'2023-06-24 15:02:33.088577',4,1);
INSERT INTO "quiz_attempter" VALUES (39,1,'2023-06-24 15:02:32.730829',4,1);
INSERT INTO "quiz_attempter" VALUES (40,1,'2023-06-24 15:02:34.784430',4,1);
INSERT INTO "quiz_attempter" VALUES (41,1,'2023-06-24 15:02:34.988735',4,1);
INSERT INTO "quiz_attempter" VALUES (42,1,'2023-06-24 15:02:35.452065',4,1);
INSERT INTO "quiz_attempter" VALUES (43,1,'2023-06-24 15:02:35.779178',4,1);
INSERT INTO "quiz_attempter" VALUES (44,1,'2023-06-24 15:13:26.909988',4,1);
INSERT INTO "quiz_attempter" VALUES (45,7,'2023-06-24 15:24:08.000918',4,1);
INSERT INTO "quiz_attempter" VALUES (46,1,'2023-06-26 13:30:06.443465',4,1);
INSERT INTO "quiz_attempter" VALUES (47,7,'2023-06-27 20:35:24.089296',4,1);
INSERT INTO "quiz_attempter" VALUES (48,0,'2023-06-27 22:25:07.681273',2,1);
INSERT INTO "quiz_attempter" VALUES (49,2,'2023-06-27 22:25:42.912131',1,1);
INSERT INTO "quiz_attempt" VALUES (1,1,1,1,1);
INSERT INTO "quiz_attempt" VALUES (2,1,2,1,1);
INSERT INTO "quiz_attempt" VALUES (3,1,3,1,1);
INSERT INTO "quiz_attempt" VALUES (4,5,4,2,2);
INSERT INTO "quiz_attempt" VALUES (5,1,5,1,1);
INSERT INTO "quiz_attempt" VALUES (6,1,6,1,4);
INSERT INTO "quiz_attempt" VALUES (7,5,6,2,4);
INSERT INTO "quiz_attempt" VALUES (8,1,7,1,4);
INSERT INTO "quiz_attempt" VALUES (9,5,7,2,4);
INSERT INTO "quiz_attempt" VALUES (10,1,8,1,4);
INSERT INTO "quiz_attempt" VALUES (11,5,8,2,4);
INSERT INTO "quiz_attempt" VALUES (12,1,9,1,4);
INSERT INTO "quiz_attempt" VALUES (13,5,9,2,4);
INSERT INTO "quiz_attempt" VALUES (14,1,11,1,4);
INSERT INTO "quiz_attempt" VALUES (15,5,11,2,4);
INSERT INTO "quiz_attempt" VALUES (16,5,12,2,2);
INSERT INTO "quiz_attempt" VALUES (17,1,13,1,4);
INSERT INTO "quiz_attempt" VALUES (18,5,13,2,4);
INSERT INTO "quiz_attempt" VALUES (19,5,14,1,4);
INSERT INTO "quiz_attempt" VALUES (20,1,15,1,4);
INSERT INTO "quiz_attempt" VALUES (21,5,15,2,4);
INSERT INTO "quiz_attempt" VALUES (22,7,25,2,4);
INSERT INTO "quiz_attempt" VALUES (23,8,25,3,4);
INSERT INTO "quiz_attempt" VALUES (24,5,26,2,4);
INSERT INTO "quiz_attempt" VALUES (25,6,26,3,4);
INSERT INTO "quiz_attempt" VALUES (26,5,27,2,4);
INSERT INTO "quiz_attempt" VALUES (27,6,27,3,4);
INSERT INTO "quiz_attempt" VALUES (28,6,28,2,4);
INSERT INTO "quiz_attempt" VALUES (29,10,30,2,4);
INSERT INTO "quiz_attempt" VALUES (30,6,30,3,4);
INSERT INTO "quiz_attempt" VALUES (31,10,31,2,4);
INSERT INTO "quiz_attempt" VALUES (32,6,31,3,4);
INSERT INTO "quiz_attempt" VALUES (33,10,33,2,4);
INSERT INTO "quiz_attempt" VALUES (34,6,33,3,4);
INSERT INTO "quiz_attempt" VALUES (35,10,32,2,4);
INSERT INTO "quiz_attempt" VALUES (36,6,32,3,4);
INSERT INTO "quiz_attempt" VALUES (37,10,34,2,4);
INSERT INTO "quiz_attempt" VALUES (38,6,34,3,4);
INSERT INTO "quiz_attempt" VALUES (39,10,35,2,4);
INSERT INTO "quiz_attempt" VALUES (40,6,35,3,4);
INSERT INTO "quiz_attempt" VALUES (41,10,36,2,4);
INSERT INTO "quiz_attempt" VALUES (42,6,36,3,4);
INSERT INTO "quiz_attempt" VALUES (43,10,38,2,4);
INSERT INTO "quiz_attempt" VALUES (44,10,37,2,4);
INSERT INTO "quiz_attempt" VALUES (45,6,37,3,4);
INSERT INTO "quiz_attempt" VALUES (46,10,39,2,4);
INSERT INTO "quiz_attempt" VALUES (47,6,39,3,4);
INSERT INTO "quiz_attempt" VALUES (48,10,40,2,4);
INSERT INTO "quiz_attempt" VALUES (49,6,40,3,4);
INSERT INTO "quiz_attempt" VALUES (50,10,41,2,4);
INSERT INTO "quiz_attempt" VALUES (51,6,41,3,4);
INSERT INTO "quiz_attempt" VALUES (52,10,42,2,4);
INSERT INTO "quiz_attempt" VALUES (53,6,42,3,4);
INSERT INTO "quiz_attempt" VALUES (54,6,38,3,4);
INSERT INTO "quiz_attempt" VALUES (55,10,43,2,4);
INSERT INTO "quiz_attempt" VALUES (56,6,43,3,4);
INSERT INTO "quiz_attempt" VALUES (57,10,44,2,4);
INSERT INTO "quiz_attempt" VALUES (58,6,44,3,4);
INSERT INTO "quiz_attempt" VALUES (59,9,45,2,4);
INSERT INTO "quiz_attempt" VALUES (60,6,45,3,4);
INSERT INTO "quiz_attempt" VALUES (61,10,46,2,4);
INSERT INTO "quiz_attempt" VALUES (62,6,46,3,4);
INSERT INTO "quiz_attempt" VALUES (63,9,47,2,4);
INSERT INTO "quiz_attempt" VALUES (64,6,47,3,4);
INSERT INTO "quiz_attempt" VALUES (65,8,48,2,2);
INSERT INTO "quiz_attempt" VALUES (66,1,49,1,1);
INSERT INTO "page_postfilecontent" VALUES (1,'user_1/BackEnd-Roadmap.pdf','2023-06-10 17:22:38.793185',1);
INSERT INTO "page_postfilecontent" VALUES (2,'user_1/banner_3v.png','2023-06-16 22:39:17.076485',1);
INSERT INTO "page_postfilecontent" VALUES (3,'user_1/IC23_Official_Rules_and_Regulations-ccd52fb1b498.pdf','2023-06-27 22:31:01.961392',1);
INSERT INTO "page_page" VALUES (1,'n','<p>n</p>',1);
INSERT INTO "page_page" VALUES (2,'Cars part','<p>Hello</p>',1);
INSERT INTO "page_page" VALUES (3,'Pulley','<p>a system</p>',1);
INSERT INTO "page_page_files" VALUES (1,1,1);
INSERT INTO "page_page_files" VALUES (2,2,2);
INSERT INTO "page_page_files" VALUES (3,3,3);
INSERT INTO "module_module" VALUES (1,'Dr Isaac Olawale',12,1);
INSERT INTO "module_module" VALUES (2,'Geography',30,1);
INSERT INTO "module_module" VALUES (3,'Victory Dance',30,1);
INSERT INTO "module_module" VALUES (5,'Mechanical Engineering',12,1);
INSERT INTO "module_module_assignments" VALUES (3,2,2);
INSERT INTO "module_module_assignments" VALUES (8,1,7);
INSERT INTO "module_module_assignments" VALUES (9,1,8);
INSERT INTO "module_module_assignments" VALUES (10,1,9);
INSERT INTO "module_module_pages" VALUES (4,2,2);
INSERT INTO "module_module_pages" VALUES (5,5,3);
INSERT INTO "module_module_pages" VALUES (6,1,2);
INSERT INTO "module_module_quizzes" VALUES (4,2,2);
INSERT INTO "module_module_quizzes" VALUES (8,1,2);
INSERT INTO "classroom_course_enrolled" VALUES (23,'d1879d5e581a45f3b38c2357f517ac5c',1);
INSERT INTO "classroom_course_enrolled" VALUES (24,'d1879d5e581a45f3b38c2357f517ac5c',9);
INSERT INTO "classroom_course_modules" VALUES (11,'d1879d5e581a45f3b38c2357f517ac5c',1);
INSERT INTO "classroom_course_questions" VALUES (9,'d1879d5e581a45f3b38c2357f517ac5c',2);
INSERT INTO "classroom_course_questions" VALUES (10,'d1879d5e581a45f3b38c2357f517ac5c',3);
INSERT INTO "classroom_grade" VALUES (3,1,'graded','d1879d5e581a45f3b38c2357f517ac5c',1,3);
INSERT INTO "classroom_grade" VALUES (4,0,'pending','d1879d5e581a45f3b38c2357f517ac5c',NULL,4);
INSERT INTO "completion_completion" VALUES (71,'2023-08-11 14:04:58.549715',7,'d1879d5e581a45f3b38c2357f517ac5c',NULL,NULL,1);
INSERT INTO "completion_completion" VALUES (72,'2023-08-11 14:08:24.050622',7,'d1879d5e581a45f3b38c2357f517ac5c',NULL,NULL,1);
INSERT INTO "direct_message" VALUES (1,'Started a new conversation','2023-06-15 13:53:35.669780',1,1,3,3);
INSERT INTO "direct_message" VALUES (2,'Hello sir','2023-06-15 13:53:42.513905',1,1,3,3);
INSERT INTO "direct_message" VALUES (3,'Hello sir','2023-06-15 13:53:42.513905',1,3,3,1);
INSERT INTO "direct_message" VALUES (4,'Started a new conversation','2023-06-15 13:55:09.572365',1,1,3,3);
INSERT INTO "direct_message" VALUES (5,'how did it go today','2023-06-15 13:55:19.324478',1,1,3,3);
INSERT INTO "direct_message" VALUES (6,'how did it go today','2023-06-15 13:55:19.324478',1,3,3,1);
INSERT INTO "direct_message" VALUES (7,'fine thank you sir','2023-06-15 13:56:27.056278',1,3,1,1);
INSERT INTO "direct_message" VALUES (8,'fine thank you sir','2023-06-15 13:56:27.064288',1,1,1,3);
INSERT INTO "direct_message" VALUES (9,'ynnnnnn to you and you alone','2023-06-15 13:56:39.598628',1,1,3,3);
INSERT INTO "direct_message" VALUES (10,'ynnnnnn to you and you alone','2023-06-15 13:56:39.678528',1,3,3,1);
INSERT INTO "direct_message" VALUES (11,'hey','2023-06-15 13:56:56.570149',1,3,1,1);
INSERT INTO "direct_message" VALUES (12,'hey','2023-06-15 13:56:56.674431',1,1,1,3);
INSERT INTO "direct_message" VALUES (13,'nice','2023-06-15 13:57:13.566022',1,3,1,1);
INSERT INTO "direct_message" VALUES (14,'nice','2023-06-15 13:57:13.662021',1,1,1,3);
INSERT INTO "direct_message" VALUES (15,'no need to shout because God will suprise you big time','2023-06-15 13:57:41.485173',1,1,3,3);
INSERT INTO "direct_message" VALUES (16,'no need to shout because God will suprise you big time','2023-06-15 13:57:41.860362',1,3,3,1);
INSERT INTO "direct_message" VALUES (17,'Started a new conversation','2023-06-15 14:03:41.453272',1,1,3,3);
INSERT INTO "direct_message" VALUES (18,'hiii','2023-06-15 14:10:45.509751',1,3,1,1);
INSERT INTO "direct_message" VALUES (19,'hiii','2023-06-15 14:10:45.525742',1,1,1,3);
INSERT INTO "direct_message" VALUES (20,'hey','2023-06-15 14:12:30.132460',1,3,1,1);
INSERT INTO "direct_message" VALUES (21,'hey','2023-06-15 14:12:30.148418',1,1,1,3);
INSERT INTO "direct_message" VALUES (22,'hello','2023-06-16 06:37:04.573362',1,1,3,3);
INSERT INTO "direct_message" VALUES (23,'hello','2023-06-16 06:37:04.577352',1,3,3,1);
INSERT INTO "direct_message" VALUES (24,'d','2023-06-16 06:37:36.876107',1,1,3,3);
INSERT INTO "direct_message" VALUES (25,'d','2023-06-16 06:37:36.882044',1,3,3,1);
INSERT INTO "direct_message" VALUES (26,'h','2023-06-16 06:39:13.038653',1,1,3,3);
INSERT INTO "direct_message" VALUES (27,'h','2023-06-16 06:39:13.048575',1,3,3,1);
INSERT INTO "direct_message" VALUES (28,'mmr','2023-06-16 06:39:22.464667',1,1,3,3);
INSERT INTO "direct_message" VALUES (29,'mmr','2023-06-16 06:39:22.473606',1,3,3,1);
INSERT INTO "direct_message" VALUES (30,'hl','2023-06-16 07:31:08.334424',1,1,3,3);
INSERT INTO "direct_message" VALUES (31,'hl','2023-06-16 07:31:08.443773',1,3,3,1);
INSERT INTO "direct_message" VALUES (32,'h','2023-06-16 07:31:25.263355',1,1,3,3);
INSERT INTO "direct_message" VALUES (33,'h','2023-06-16 07:31:25.278972',1,3,3,1);
INSERT INTO "direct_message" VALUES (34,'b','2023-06-16 07:35:57.186092',1,1,3,3);
INSERT INTO "direct_message" VALUES (35,'b','2023-06-16 07:35:57.201715',1,3,3,1);
INSERT INTO "direct_message" VALUES (36,'n','2023-06-16 07:37:18.452308',1,1,3,3);
INSERT INTO "direct_message" VALUES (37,'n','2023-06-16 07:37:18.452308',1,3,3,1);
INSERT INTO "direct_message" VALUES (38,'bjbkb','2023-06-16 07:37:30.904673',1,1,3,3);
INSERT INTO "direct_message" VALUES (39,'bjbkb','2023-06-16 07:37:30.920333',1,3,3,1);
INSERT INTO "direct_message" VALUES (40,'nnnnn','2023-06-16 07:37:33.960870',1,1,3,3);
INSERT INTO "direct_message" VALUES (41,'nnnnn','2023-06-16 07:37:33.960870',1,3,3,1);
INSERT INTO "direct_message" VALUES (42,'nnnnnnn''''','2023-06-16 07:37:46.558041',1,1,3,3);
INSERT INTO "direct_message" VALUES (43,'nnnnnnn''''','2023-06-16 07:37:46.558041',1,3,3,1);
INSERT INTO "direct_message" VALUES (44,'n','2023-06-16 07:40:08.620956',1,1,3,3);
INSERT INTO "direct_message" VALUES (45,'n','2023-06-16 07:40:08.730309',1,3,3,1);
INSERT INTO "direct_message" VALUES (46,'hello clear','2023-06-16 07:46:13.138956',1,3,1,1);
INSERT INTO "direct_message" VALUES (47,'hello clear','2023-06-16 07:46:13.146953',1,1,1,3);
INSERT INTO "direct_message" VALUES (48,'Jesus Loves you sir','2023-06-16 07:49:22.961874',1,1,3,3);
INSERT INTO "direct_message" VALUES (49,'Jesus Loves you sir','2023-06-16 07:49:23.055600',1,3,3,1);
INSERT INTO "direct_message" VALUES (50,'thank you sir','2023-06-16 07:49:51.902050',1,3,1,1);
INSERT INTO "direct_message" VALUES (51,'thank you sir','2023-06-16 07:49:51.910055',1,1,1,3);
INSERT INTO "direct_message" VALUES (52,'hello','2023-06-16 07:53:34.020179',1,1,3,3);
INSERT INTO "direct_message" VALUES (53,'hello','2023-06-16 07:53:34.035813',1,3,3,1);
INSERT INTO "direct_message" VALUES (54,'hi','2023-06-16 07:55:08.092084',1,1,3,3);
INSERT INTO "direct_message" VALUES (55,'hi','2023-06-16 07:55:08.107704',1,3,3,1);
INSERT INTO "direct_message" VALUES (56,'hi','2023-06-16 07:55:55.718176',1,1,3,3);
INSERT INTO "direct_message" VALUES (57,'hi','2023-06-16 07:55:55.733752',1,3,3,1);
INSERT INTO "direct_message" VALUES (58,'bye','2023-06-16 07:57:20.269671',1,1,3,3);
INSERT INTO "direct_message" VALUES (59,'bye','2023-06-16 07:57:20.269671',1,3,3,1);
INSERT INTO "direct_message" VALUES (60,'ynn','2023-06-16 07:57:38.720312',1,1,3,3);
INSERT INTO "direct_message" VALUES (61,'ynn','2023-06-16 07:57:38.720312',1,3,3,1);
INSERT INTO "direct_message" VALUES (62,'nice','2023-06-16 08:04:29.880991',1,1,3,3);
INSERT INTO "direct_message" VALUES (63,'nice','2023-06-16 08:04:29.990386',1,3,3,1);
INSERT INTO "direct_message" VALUES (64,'','2023-06-16 08:41:45.481056',1,1,3,3);
INSERT INTO "direct_message" VALUES (65,'','2023-06-16 08:41:45.496679',1,3,3,1);
INSERT INTO "direct_message" VALUES (66,'nu','2023-06-16 08:42:22.473773',1,1,3,3);
INSERT INTO "direct_message" VALUES (67,'nu','2023-06-16 08:42:22.489391',1,3,3,1);
INSERT INTO "direct_message" VALUES (68,'thanks','2023-06-16 08:43:29.105353',1,3,1,1);
INSERT INTO "direct_message" VALUES (69,'thanks','2023-06-16 08:43:29.113992',1,1,1,3);
INSERT INTO "direct_message" VALUES (70,'j','2023-06-16 08:48:07.447769',1,3,1,1);
INSERT INTO "direct_message" VALUES (71,'j','2023-06-16 08:48:07.455714',1,1,1,3);
INSERT INTO "direct_message" VALUES (72,'hi','2023-06-16 09:03:44.443010',1,3,5,5);
INSERT INTO "direct_message" VALUES (73,'hi','2023-06-16 09:03:44.451011',1,5,5,3);
INSERT INTO "direct_message" VALUES (74,'hello','2023-06-16 19:16:12.095674',1,5,6,6);
INSERT INTO "direct_message" VALUES (75,'hello','2023-06-16 19:16:12.111301',1,6,6,5);
INSERT INTO "direct_message" VALUES (76,'hi clear','2023-06-16 19:16:20.008567',1,3,6,6);
INSERT INTO "direct_message" VALUES (77,'hi clear','2023-06-16 19:16:20.024186',0,6,6,3);
INSERT INTO "direct_message" VALUES (78,'Hello sir admin','2023-06-16 19:16:29.121135',1,1,6,6);
INSERT INTO "direct_message" VALUES (79,'Hello sir admin','2023-06-16 19:16:29.136755',1,6,6,1);
INSERT INTO "direct_message" VALUES (80,'hello Mr victor nice meeting you.','2023-06-16 23:05:19.908850',1,6,5,5);
INSERT INTO "direct_message" VALUES (81,'hello Mr victor nice meeting you.','2023-06-16 23:05:19.908850',0,5,5,6);
INSERT INTO "direct_message" VALUES (82,'quiz in 10 minutes','2023-06-19 04:43:11.189962',1,1,1,1);
INSERT INTO "direct_message" VALUES (83,'quiz in 10 minutes','2023-06-19 04:43:11.201923',1,1,1,1);
INSERT INTO "direct_message" VALUES (84,'quiz in 10 minutes','2023-06-19 04:43:11.554076',1,3,1,1);
INSERT INTO "direct_message" VALUES (85,'quiz in 10 minutes','2023-06-19 04:43:11.564051',1,1,1,3);
INSERT INTO "direct_message" VALUES (86,'hi','2023-06-19 04:45:28.305390',1,1,1,1);
INSERT INTO "direct_message" VALUES (87,'hi','2023-06-19 04:45:28.309381',1,1,1,1);
INSERT INTO "direct_message" VALUES (88,'h','2023-06-19 08:37:54.399844',1,3,1,1);
INSERT INTO "direct_message" VALUES (89,'h','2023-06-19 08:37:54.399844',1,1,1,3);
INSERT INTO "direct_message" VALUES (90,'Jesus Loves you sir','2023-06-19 08:38:12.376281',1,3,1,1);
INSERT INTO "direct_message" VALUES (91,'Jesus Loves you sir','2023-06-19 08:38:12.398416',1,1,1,3);
INSERT INTO "direct_message" VALUES (92,'Jesus Loves you sir','2023-06-19 08:38:41.383696',1,3,1,1);
INSERT INTO "direct_message" VALUES (93,'Jesus Loves you sir','2023-06-19 08:38:41.390252',1,1,1,3);
INSERT INTO "direct_message" VALUES (94,'','2023-06-19 08:54:28.351847',1,1,1,1);
INSERT INTO "direct_message" VALUES (95,'','2023-06-19 08:54:28.367439',1,1,1,1);
INSERT INTO "direct_message" VALUES (96,'','2023-06-19 08:54:28.520035',1,1,1,1);
INSERT INTO "direct_message" VALUES (97,'','2023-06-19 08:54:28.535633',1,1,1,1);
INSERT INTO "direct_message" VALUES (98,'','2023-06-19 08:54:30.058331',1,1,1,1);
INSERT INTO "direct_message" VALUES (99,'','2023-06-19 08:54:30.095949',1,1,1,1);
INSERT INTO "direct_message" VALUES (100,'you too','2023-06-19 08:59:00.652445',1,3,1,1);
INSERT INTO "direct_message" VALUES (101,'you too','2023-06-19 08:59:00.752701',0,1,1,3);
INSERT INTO "direct_message" VALUES (102,'f','2023-06-19 08:59:09.143324',1,3,1,1);
INSERT INTO "direct_message" VALUES (103,'f','2023-06-19 08:59:09.158953',0,1,1,3);
INSERT INTO "direct_message" VALUES (104,'ynn','2023-06-19 09:02:54.907098',1,3,1,1);
INSERT INTO "direct_message" VALUES (105,'ynn','2023-06-19 09:02:54.922727',0,1,1,3);
INSERT INTO "direct_message" VALUES (106,'','2023-06-19 09:02:56.955842',1,3,1,1);
INSERT INTO "direct_message" VALUES (107,'','2023-06-19 09:02:58.345047',0,1,1,3);
INSERT INTO "direct_message" VALUES (108,'ynnn','2023-06-19 09:03:04.428891',1,3,1,1);
INSERT INTO "direct_message" VALUES (109,'ynnn','2023-06-19 09:03:05.162226',0,1,1,3);
INSERT INTO "direct_message" VALUES (110,'Started a new conversation','2023-06-20 08:46:06.291508',1,1,5,5);
INSERT INTO "direct_message" VALUES (111,'hi','2023-06-20 08:46:17.936720',1,1,5,5);
INSERT INTO "direct_message" VALUES (112,'hi','2023-06-20 08:46:17.944720',1,5,5,1);
INSERT INTO "direct_message" VALUES (113,'lets talk','2023-06-20 08:54:00.271291',1,1,5,5);
INSERT INTO "direct_message" VALUES (114,'lets talk','2023-06-20 08:54:00.279291',1,5,5,1);
INSERT INTO "direct_message" VALUES (115,'Started a new conversation','2023-06-30 12:04:18.855267',1,1,9,9);
INSERT INTO "direct_message" VALUES (116,'Good afternoon sir','2023-06-30 12:04:29.795318',1,1,9,9);
INSERT INTO "direct_message" VALUES (117,'Good afternoon sir','2023-06-30 12:04:29.801814',1,9,9,1);
INSERT INTO "direct_message" VALUES (118,'n','2023-06-30 12:04:38.535594',1,1,9,9);
INSERT INTO "direct_message" VALUES (119,'n','2023-06-30 12:04:38.542561',1,9,9,1);
INSERT INTO "direct_message" VALUES (120,'fklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuo','2023-06-30 12:04:49.275111',1,1,9,9);
INSERT INTO "direct_message" VALUES (121,'fklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuofklrjwrworwourwuo','2023-06-30 12:04:49.279307',1,9,9,1);
INSERT INTO "direct_message" VALUES (122,'How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing ','2023-06-30 12:05:15.368143',1,1,9,9);
INSERT INTO "direct_message" VALUES (123,'How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing ','2023-06-30 12:05:15.375159',1,9,9,1);
INSERT INTO "direct_message" VALUES (124,'How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing ','2023-06-30 12:05:22.379920',1,1,9,9);
INSERT INTO "direct_message" VALUES (125,'How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing ','2023-06-30 12:05:22.387840',1,9,9,1);
INSERT INTO "direct_message" VALUES (126,'How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thingHow was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thingHow was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thingHow was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing','2023-06-30 12:05:33.366522',1,1,9,9);
INSERT INTO "direct_message" VALUES (127,'How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thingHow was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thingHow was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thingHow was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing','2023-06-30 12:05:33.373498',1,9,9,1);
INSERT INTO "direct_message" VALUES (128,'How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thingHow was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thingHow was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thingHow was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thingHow was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing','2023-06-30 12:05:42.750886',1,1,9,9);
INSERT INTO "direct_message" VALUES (129,'How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thingHow was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thingHow was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thingHow was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thingHow was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing How was your night and every thing','2023-06-30 12:05:42.756176',1,9,9,1);
INSERT INTO "direct_message" VALUES (130,'fine sir','2023-06-30 12:06:40.843163',1,9,1,1);
INSERT INTO "direct_message" VALUES (131,'fine sir','2023-06-30 12:06:40.849074',0,1,1,9);
INSERT INTO "direct_message" VALUES (132,'Started a new conversation','2023-08-11 20:23:03.961305',1,9,1,1);
INSERT INTO "direct_message" VALUES (133,'Hello Sir','2023-08-11 20:23:23.097826',1,9,1,1);
INSERT INTO "direct_message" VALUES (134,'Hello Sir','2023-08-11 20:23:23.179607',0,1,1,9);
INSERT INTO "quiz_quizzes" VALUES (1,'now','<p>THanks</p>','2023-06-10 17:24:08.015140','2023-06-07',12,1,20);
INSERT INTO "quiz_quizzes" VALUES (2,'GEC 321','<p>mn</p>','2023-06-13 09:40:45.113615','2023-06-27',5,1,13);
INSERT INTO "quiz_quizzes" VALUES (3,'Gender','mmmmmm','2023-06-13 10:31:45.260287','2023-06-20',4,1,13);
INSERT INTO "quiz_quizzes" VALUES (4,'GEC 226','<p>yn</p>','2023-06-17 13:45:32.297810','2023-06-27',100,1,10);
INSERT INTO "django_session" VALUES ('vnbm0hm4l2tgbktu0dgueh50w0m74r1a','.eJxVjEEOgjAQRe_StWlapgPWpXvOQGY6U4saSCisjHdXEha6_e-9_zIDbWsZtqrLMIq5GG9OvxtTeui0A7nTdJttmqd1Gdnuij1otf0s-rwe7t9BoVq-NVPOjIKiCErQQQOcMUaMiufsKUrHCKAYyGXfUQrCkAIEatrWOTXvDwn1OF0:1q80xO:fQzWEgPBzVWYlgFAZewbOenXybItynTGEyRkWtuvOwU','2023-06-24 15:56:50.223329');
INSERT INTO "django_session" VALUES ('2kxi2ss5w44kwej8oxnh68y1713ba305','.eJxVjDsOwjAQBe_iGll24tgbSvqcwVrvekkA2VI-FeLuJFIKaN_MvLeKuK1j3JY8x4nVVbXq8rslpGcuB-AHlnvVVMs6T0kfij7poofK-XU73b-DEZdxr8EIty50ScgyOvbQ95w6CM43RiShJcAdGguNhSxMPRpsyLeBDAirzxf9CzjF:1q8Nsa:oZa1aKIvypRaZ85UjKL6tV8qQUI8N8sriVLSH-3H3SE','2023-06-25 16:25:24.072713');
INSERT INTO "django_session" VALUES ('gh2kp1lr4rksy518b2lf4z1cmvtatc04','.eJxVjEEOgjAQRa9iujYNOB2wLN17hmbamdqqgaSALIx3FxIWuv3v_fdWjuYpuXmU4jKrTtXq-Lt5Cg_pN8B36m-DDkM_lez1puidjvo6sDwvu_sXSDSm9e0pRo-MLAhC0MIJfERr0QqeY02WW48AgoaqWLcUDHsIBgydmqaqZI2-sizCLiTK5bCobiqzfL44MUBI:1q8ck1:enkKprLUMPYTQ_sJijPI7Ls6fi5SrqoWH72sQh6wrC4','2023-06-26 08:17:33.055627');
INSERT INTO "django_session" VALUES ('ie100vlsvytaemckx3yps9f66acnj3gx','.eJxVjEEOgjAQRe_StWlapgPWpXvOQGY6U4saSCisjHdXEha6_e-9_zIDbWsZtqrLMIq5GG9OvxtTeui0A7nTdJttmqd1Gdnuij1otf0s-rwe7t9BoVq-NVPOjIKiCErQQQOcMUaMiufsKUrHCKAYyGXfUQrCkAIEatrWOTXvDwn1OF0:1q9Krx:SnRpSLr2SzKPSQdDVQCWX7UmZLcJjvcXtmINPr6wBow','2023-06-28 07:24:41.277625');
INSERT INTO "django_session" VALUES ('1c0zmq8j4wnu1qm3b9xnxvjezcw1ec4q','.eJxVjEEOgjAQRe_StWlapgPWpXvOQGY6U4saSCisjHdXEha6_e-9_zIDbWsZtqrLMIq5GG9OvxtTeui0A7nTdJttmqd1Gdnuij1otf0s-rwe7t9BoVq-NVPOjIKiCErQQQOcMUaMiufsKUrHCKAYyGXfUQrCkAIEatrWOTXvDwn1OF0:1qAIMH:5zCD9QIQtST5_ywSVD6Kl61vzov1LfI4Ajvu7fT23zE','2023-06-30 22:55:57.978730');
INSERT INTO "django_session" VALUES ('nn2h2u1e5dy5cfrtnwj2lu1jvxspya7y','.eJxVjMEOwiAQRP-FsyEFXCgevfsNZGEXqRpISnsy_rtt0oMeZ96beYuA61LC2nkOE4mLAHH67SKmJ9cd0APrvcnU6jJPUe6KPGiXt0b8uh7u30HBXra1BbIOM2ijmSkmUj5FQiR9xmzGYSTWCliBZTDWb2HQyrFm71S2HsTnCwRrOAc:1qAIP4:0LpVzyiv9ZM5w-Y2zKpk4aTrVR1QzITSblc1JhL-l-Q','2023-06-30 22:58:50.971880');
INSERT INTO "django_session" VALUES ('eyffihop9pvtn0iz814vqg0ziolirbq9','.eJxVjEEOgjAQRe_StWlapgPWpXvOQGY6U4saSCisjHdXEha6_e-9_zIDbWsZtqrLMIq5GG9OvxtTeui0A7nTdJttmqd1Gdnuij1otf0s-rwe7t9BoVq-NVPOjIKiCErQQQOcMUaMiufsKUrHCKAYyGXfUQrCkAIEatrWOTXvDwn1OF0:1qBWkq:07Twz5oJT_PwV0NrO50YyEtjXBNb9kCKTO-SYy15sXc','2023-07-04 08:30:24.910582');
INSERT INTO "django_session" VALUES ('w9dscnff7utd0h8f820bscuia9eym93g','.eJxVjEEOgjAQRe_StWlapgPWpXvOQGY6U4saSCisjHdXEha6_e-9_zIDbWsZtqrLMIq5GG9OvxtTeui0A7nTdJttmqd1Gdnuij1otf0s-rwe7t9BoVq-NVPOjIKiCErQQQOcMUaMiufsKUrHCKAYyGXfUQrCkAIEatrWOTXvDwn1OF0:1qFCIW:2630JnVYhIQlBrzZoSMqy0HcmymkPOE6vI_wRB5jH4I','2023-07-14 11:28:20.704213');
INSERT INTO "django_session" VALUES ('xyu4mpoiu1jx1bndfyuv2bc7dnnspcqr','.eJxVjMsOwiAQRf-FtSG8IoNL934DmYFBqgaS0q4a_12bdKHbe865m4i4LjWug-c4ZXERQZx-N8L05LaD_MB27zL1tswTyV2RBx3y1jO_rof7d1Bx1G_tgAuqYiGYTBzOziGZYgySQp0gk7baeUQV2Fkg8FmHROhZ6WSAtXh_APvqOFQ:1qFCLl:7tAwx8VswYCIuiNylD58o1u9JWk_T0_MSuYLHsRufoU','2023-07-14 11:31:41.352107');
INSERT INTO "django_session" VALUES ('rew7wjzze1g50jihlkrow0jw5d26zyc2','.eJxVjEEOgjAQRe_StWlapgPWpXvOQGY6U4saSCisjHdXEha6_e-9_zIDbWsZtqrLMIq5GG9OvxtTeui0A7nTdJttmqd1Gdnuij1otf0s-rwe7t9BoVq-NVPOjIKiCErQQQOcMUaMiufsKUrHCKAYyGXfUQrCkAIEatrWOTXvDwn1OF0:1qM6WW:LGf8rupHExFyNThjLtYfWAw2b7AeKvRLcffFQ1M-Bfg','2023-08-02 12:43:20.590145');
INSERT INTO "django_session" VALUES ('qavqdgd0xxwdkbou2bo8ob6jmjubar6a','.eJxVjEEOgjAQRe_StWlapgPWpXvOQGY6U4saSCisjHdXEha6_e-9_zIDbWsZtqrLMIq5GG9OvxtTeui0A7nTdJttmqd1Gdnuij1otf0s-rwe7t9BoVq-NVPOjIKiCErQQQOcMUaMiufsKUrHCKAYyGXfUQrCkAIEatrWOTXvDwn1OF0:1qUTS9:vDkUaToa3k3uy4lrHInUm__ZXd3drt7683bqUMkqMnM','2023-08-25 14:49:25.471923');
INSERT INTO "django_session" VALUES ('h7q9jaah0rh3gceu2wunzvjq7dvk8z8o','.eJxVjEEOgjAQRe_StWlapgPWpXvOQGY6U4saSCisjHdXEha6_e-9_zIDbWsZtqrLMIq5GG9OvxtTeui0A7nTdJttmqd1Gdnuij1otf0s-rwe7t9BoVq-NVPOjIKiCErQQQOcMUaMiufsKUrHCKAYyGXfUQrCkAIEatrWOTXvDwn1OF0:1qVF8P:4ZfR2Hbs0lkYMmur2txDbQdGwUgzdhxW29TuQ_YGwMg','2023-08-27 17:44:13.295651');
INSERT INTO "django_session" VALUES ('h5dpf6pouv52ioy2wixxep20g0ik35sy','.eJxVjEEOgjAQRe_StWlapgPWpXvOQGY6U4saSCisjHdXEha6_e-9_zIDbWsZtqrLMIq5GG9OvxtTeui0A7nTdJttmqd1Gdnuij1otf0s-rwe7t9BoVq-NVPOjIKiCErQQQOcMUaMiufsKUrHCKAYyGXfUQrCkAIEatrWOTXvDwn1OF0:1qVFUY:MSvOOePveT7GIMTQsvV7O3umddguNr7jwMF4J_ddvnc','2023-08-27 18:07:06.024913');
INSERT INTO "authy_profile" VALUES (1,'flat 3, Garki 11, Abuja, Nigeria','abs','d','2023-06-10','user_1/profile.jpg','',1,'Basic','tag website','banner/nysc.jpeg','I love reading','tag city','tag','2023-06-12 07:38:05',0,'#','#','profile_pics/nysc.jpeg','#','tag','#','2023-08-13 18:07:06.009250','tag');
INSERT INTO "authy_profile" VALUES (3,NULL,'abs','','2023-06-11','user_3/profile.jpg','',3,NULL,'tag website','slider-1.jpg','I love reading','tag city','tag','2023-06-12 07:38:05',0,'#','#','profile_pics/team-4.jpg','#','tag','#','2023-08-11 13:29:25.227130','tag');
INSERT INTO "authy_profile" VALUES (4,NULL,'abs','','2023-06-11','user_4/profile.jpg','',4,NULL,'tag website','slider-1.jpg','I love reading','tag city','tag','2023-06-12 07:38:05.335484',0,'#','#','profile-pic-default.jpg','#','tag','#','2023-06-12 07:38:05.570204','tag');
INSERT INTO "authy_profile" VALUES (5,NULL,'abs',NULL,'2023-06-16','','',5,NULL,'tag website','slider-1.jpg','I love reading','tag city','tag','2023-06-16 08:56:17.379855',0,'#','#','profile-pic-default.jpg','#','tag','#','2023-06-29 19:27:30.722375','tag');
INSERT INTO "authy_profile" VALUES (6,NULL,'abs',NULL,'2023-06-16','','',6,NULL,'tag website','slider-1.jpg','I love reading','tag city','tag','2023-06-16 19:14:50.818831',0,'#','#','profile-pic-default.jpg','#','tag','#','2023-06-16 19:15:07.473453','tag');
INSERT INTO "authy_profile" VALUES (7,NULL,'abs',NULL,'2023-06-27','','',7,NULL,'tag website','slider-1.jpg','I love reading','tag city','tag','2023-06-27 19:31:25.906193',0,'#','#','profile-pic-default.jpg','#','tag','#','2023-06-27 19:31:25.917420','tag');
INSERT INTO "authy_profile" VALUES (8,NULL,'abs',NULL,'2023-06-27','','',8,NULL,'tag website','slider-1.jpg','I love reading','tag city','tag','2023-06-27 19:35:31.544941',0,'#','#','profile-pic-default.jpg','#','tag','#','2023-06-27 19:35:31.553358','tag');
INSERT INTO "authy_profile" VALUES (9,NULL,'abs',NULL,'2023-06-30','','',9,NULL,'tag website','slider-1.jpg','I love reading','tag city','tag','2023-06-30 11:31:31.598152',0,'#','#','profile-pic-default.jpg','#','tag','#','2023-08-11 20:22:32.819351','tag');
INSERT INTO "authy_profile" VALUES (10,NULL,'abs',NULL,'2023-08-11','','',10,NULL,'tag website','slider-1.jpg','I love reading','tag city','tag','2023-08-11 19:27:59.276422',0,'#','#','profile-pic-default.jpg','#','tag','#','2023-08-11 19:28:10.082145','tag');
INSERT INTO "classroom_course" VALUES ('d1879d5e581a45f3b38c2357f517ac5c','user_1/bk_b1oYBuE.jpg','Garki 1 branch','A detist branch which is closest to your location','<p>Brush your teeth morning, afternoon and evening</p>',1,4,10);
INSERT INTO "livestream_livestream" VALUES (17,'live stream on gender happening in 2 minutes',1,NULL,1,1,1);
INSERT INTO "livestream_livestream" VALUES (18,'live stream on gender happening in 2 minutes',1,NULL,3,1,1);
INSERT INTO "livestream_livestream" VALUES (19,'live stream on gender happening in 2 minutes',0,NULL,1,1,3);
INSERT INTO "livestream_livestream" VALUES (20,'12345678909876',1,NULL,1,1,1);
INSERT INTO "livestream_livestream" VALUES (21,'12345678909876',1,NULL,1,1,1);
INSERT INTO "livestream_livestream" VALUES (22,'12345678909876',1,NULL,3,1,1);
INSERT INTO "livestream_livestream" VALUES (23,'12345678909876',0,NULL,1,1,3);
INSERT INTO "livestream_livestream" VALUES (24,'Hope',1,NULL,1,1,1);
INSERT INTO "livestream_livestream" VALUES (25,'Hope',1,NULL,1,1,1);
INSERT INTO "livestream_livestream" VALUES (26,'Hope',1,NULL,3,1,1);
INSERT INTO "livestream_livestream" VALUES (27,'Hope',0,NULL,1,1,3);
INSERT INTO "livestream_livestream" VALUES (28,'Hope',1,NULL,5,1,1);
INSERT INTO "livestream_livestream" VALUES (29,'Hope',1,NULL,1,1,5);
INSERT INTO "livestream_livestream" VALUES (30,'when is quiz',1,NULL,1,5,5);
INSERT INTO "livestream_livestream" VALUES (31,'when is quiz',1,NULL,5,5,1);
INSERT INTO "livestream_livestream" VALUES (32,'After the live stream sent',1,NULL,1,1,1);
INSERT INTO "livestream_livestream" VALUES (33,'After the live stream sent',1,NULL,1,1,1);
INSERT INTO "livestream_livestream" VALUES (34,'URll livestream
',1,NULL,1,1,1);
INSERT INTO "livestream_livestream" VALUES (35,'URll livestream
',1,NULL,1,1,1);
INSERT INTO "livestream_livestream" VALUES (36,'URll livestream
',1,NULL,9,1,1);
INSERT INTO "livestream_livestream" VALUES (37,'URll livestream
',1,NULL,1,1,9);
INSERT INTO "livestream_livestream" VALUES (38,'Started a new conversation',1,NULL,1,9,9);
INSERT INTO "livestream_livestream" VALUES (39,'hello',1,NULL,1,1,1);
INSERT INTO "livestream_livestream" VALUES (40,'hello',1,NULL,1,1,1);
INSERT INTO "livestream_livestream" VALUES (41,'hi sir',1,NULL,1,9,9);
INSERT INTO "livestream_livestream" VALUES (42,'hi sir',1,NULL,9,9,1);
INSERT INTO "livestream_livestream" VALUES (43,'Started a new conversation',1,NULL,9,1,1);
INSERT INTO "livestream_livestream" VALUES (44,',mmm',1,NULL,1,1,1);
INSERT INTO "livestream_livestream" VALUES (45,',mmm',0,NULL,1,1,1);
INSERT INTO "livestream_livestream" VALUES (46,',mmm',1,NULL,9,1,1);
INSERT INTO "livestream_livestream" VALUES (47,',mmm',0,NULL,1,1,9);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ON "auth_group_permissions" (
	"group_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions" (
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions" (
	"permission_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_groups_user_id_group_id_94350c0c_uniq" ON "auth_user_groups" (
	"user_id",
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_user_id_6a12ed8b" ON "auth_user_groups" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_group_id_97559544" ON "auth_user_groups" (
	"group_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_permission_id_14a6b632_uniq" ON "auth_user_user_permissions" (
	"user_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_a95ead1b" ON "auth_user_user_permissions" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_permission_id_1fbb5f2c" ON "auth_user_user_permissions" (
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_user_id_c564eba6" ON "django_admin_log" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "assignment_submission_assignment_id_607c0502" ON "assignment_submission" (
	"assignment_id"
);
CREATE INDEX IF NOT EXISTS "assignment_submission_user_id_6097f150" ON "assignment_submission" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "assignment_assignmentfilecontent_user_id_343205bd" ON "assignment_assignmentfilecontent" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "assignment_assignment_files_assignment_id_assignmentfilecontent_id_6d0267d3_uniq" ON "assignment_assignment_files" (
	"assignment_id",
	"assignmentfilecontent_id"
);
CREATE INDEX IF NOT EXISTS "assignment_assignment_files_assignment_id_2bb75ece" ON "assignment_assignment_files" (
	"assignment_id"
);
CREATE INDEX IF NOT EXISTS "assignment_assignment_files_assignmentfilecontent_id_37774b92" ON "assignment_assignment_files" (
	"assignmentfilecontent_id"
);
CREATE INDEX IF NOT EXISTS "assignment_assignment_user_id_b66c9f0b" ON "assignment_assignment" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "django_content_type_app_label_model_76bd3d3b_uniq" ON "django_content_type" (
	"app_label",
	"model"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_permission_content_type_id_codename_01ab375a_uniq" ON "auth_permission" (
	"content_type_id",
	"codename"
);
CREATE INDEX IF NOT EXISTS "auth_permission_content_type_id_2f476e4b" ON "auth_permission" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "taggit_taggeditem_object_id_e2d7d1df" ON "taggit_taggeditem" (
	"object_id"
);
CREATE INDEX IF NOT EXISTS "taggit_taggeditem_content_type_id_9957a03c" ON "taggit_taggeditem" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "taggit_taggeditem_tag_id_f4f5b767" ON "taggit_taggeditem" (
	"tag_id"
);
CREATE INDEX IF NOT EXISTS "taggit_taggeditem_content_type_id_object_id_196cc965_idx" ON "taggit_taggeditem" (
	"content_type_id",
	"object_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "taggit_taggeditem_content_type_id_object_id_tag_id_4bb97a8e_uniq" ON "taggit_taggeditem" (
	"content_type_id",
	"object_id",
	"tag_id"
);
CREATE INDEX IF NOT EXISTS "blog_article_slug_c3fca16d" ON "blog_article" (
	"slug"
);
CREATE INDEX IF NOT EXISTS "blog_article_author_id_905add38" ON "blog_article" (
	"author_id"
);
CREATE INDEX IF NOT EXISTS "blog_article_category_id_7e38f15e" ON "blog_article" (
	"category_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "blog_category_name_92eb1483_uniq" ON "blog_category" (
	"name"
);
CREATE INDEX IF NOT EXISTS "blog_category_slug_92643dc5" ON "blog_category" (
	"slug"
);
CREATE INDEX IF NOT EXISTS "blog_course_slug_19791e03" ON "blog_course" (
	"slug"
);
CREATE INDEX IF NOT EXISTS "blog_course_article_id_6145bde0" ON "blog_course" (
	"article_id"
);
CREATE INDEX IF NOT EXISTS "blog_course_author_id_ffb6908a" ON "blog_course" (
	"author_id"
);
CREATE INDEX IF NOT EXISTS "blog_commentcourse_course_id_fd7dc5d2" ON "blog_commentcourse" (
	"course_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "blog_subject_title_160dbe4f_uniq" ON "blog_subject" (
	"title"
);
CREATE INDEX IF NOT EXISTS "blog_subject_slug_d9ef5fc0" ON "blog_subject" (
	"slug"
);
CREATE INDEX IF NOT EXISTS "blog_subject_author_id_ac4b22a5" ON "blog_subject" (
	"author_id"
);
CREATE INDEX IF NOT EXISTS "blog_subject_course_id_709a1cba" ON "blog_subject" (
	"course_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "blog_room_title_8b30ed9e_uniq" ON "blog_room" (
	"title"
);
CREATE INDEX IF NOT EXISTS "blog_room_slug_adc8240c" ON "blog_room" (
	"slug"
);
CREATE INDEX IF NOT EXISTS "blog_room_author_id_482e7518" ON "blog_room" (
	"author_id"
);
CREATE INDEX IF NOT EXISTS "blog_room_subject_id_f6140c42" ON "blog_room" (
	"subject_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "blog_rep_title_aeafb5ca_uniq" ON "blog_rep" (
	"title"
);
CREATE INDEX IF NOT EXISTS "blog_rep_slug_558e3871" ON "blog_rep" (
	"slug"
);
CREATE INDEX IF NOT EXISTS "blog_rep_author_id_6f93adaf" ON "blog_rep" (
	"author_id"
);
CREATE INDEX IF NOT EXISTS "blog_rep_room_id_6e81320f" ON "blog_rep" (
	"room_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "blog_mem_title_42fcebc8_uniq" ON "blog_mem" (
	"title"
);
CREATE INDEX IF NOT EXISTS "blog_mem_slug_3a526323" ON "blog_mem" (
	"slug"
);
CREATE INDEX IF NOT EXISTS "blog_mem_author_id_105c1618" ON "blog_mem" (
	"author_id"
);
CREATE INDEX IF NOT EXISTS "blog_mem_rep_id_be15c7d2" ON "blog_mem" (
	"rep_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "blog_table_title_1d0d27b0_uniq" ON "blog_table" (
	"title"
);
CREATE INDEX IF NOT EXISTS "blog_table_slug_b1070fec" ON "blog_table" (
	"slug"
);
CREATE INDEX IF NOT EXISTS "blog_table_author_id_1a5a1ba4" ON "blog_table" (
	"author_id"
);
CREATE INDEX IF NOT EXISTS "blog_table_mem_id_5d37c12e" ON "blog_table" (
	"mem_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "blog_chair_title_61eabfdd_uniq" ON "blog_chair" (
	"title"
);
CREATE INDEX IF NOT EXISTS "blog_chair_slug_e8d5cd53" ON "blog_chair" (
	"slug"
);
CREATE INDEX IF NOT EXISTS "blog_chair_author_id_da6d91e3" ON "blog_chair" (
	"author_id"
);
CREATE INDEX IF NOT EXISTS "blog_chair_table_id_a73aef41" ON "blog_chair" (
	"table_id"
);
CREATE INDEX IF NOT EXISTS "blog_comment_chair_id_6d3ae030" ON "blog_comment" (
	"chair_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "blog_chair_enrolled_chair_id_user_id_4727aff7_uniq" ON "blog_chair_enrolled" (
	"chair_id",
	"user_id"
);
CREATE INDEX IF NOT EXISTS "blog_chair_enrolled_chair_id_f01f4f61" ON "blog_chair_enrolled" (
	"chair_id"
);
CREATE INDEX IF NOT EXISTS "blog_chair_enrolled_user_id_077157e9" ON "blog_chair_enrolled" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "question_votes_answer_id_037cb082" ON "question_votes" (
	"answer_id"
);
CREATE INDEX IF NOT EXISTS "question_votes_user_id_63d4efee" ON "question_votes" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "question_question_user_id_6ae5c0ef" ON "question_question" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "question_answer_question_id_2220065b" ON "question_answer" (
	"question_id"
);
CREATE INDEX IF NOT EXISTS "question_answer_user_id_1e93b02f" ON "question_answer" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "quiz_answer_user_id_42c7c6cb" ON "quiz_answer" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "quiz_question_user_id_c015f9f3" ON "quiz_question" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "quiz_question_answers_question_id_answer_id_2c792f29_uniq" ON "quiz_question_answers" (
	"question_id",
	"answer_id"
);
CREATE INDEX IF NOT EXISTS "quiz_question_answers_question_id_3e562df5" ON "quiz_question_answers" (
	"question_id"
);
CREATE INDEX IF NOT EXISTS "quiz_question_answers_answer_id_508372d0" ON "quiz_question_answers" (
	"answer_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "quiz_quizzes_questions_quizzes_id_question_id_efa6bcd8_uniq" ON "quiz_quizzes_questions" (
	"quizzes_id",
	"question_id"
);
CREATE INDEX IF NOT EXISTS "quiz_quizzes_questions_quizzes_id_f423c6c7" ON "quiz_quizzes_questions" (
	"quizzes_id"
);
CREATE INDEX IF NOT EXISTS "quiz_quizzes_questions_question_id_3fbe529c" ON "quiz_quizzes_questions" (
	"question_id"
);
CREATE INDEX IF NOT EXISTS "quiz_attempter_quiz_id_ff50946f" ON "quiz_attempter" (
	"quiz_id"
);
CREATE INDEX IF NOT EXISTS "quiz_attempter_user_id_b9e20229" ON "quiz_attempter" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "quiz_attempt_answer_id_02ed946e" ON "quiz_attempt" (
	"answer_id"
);
CREATE INDEX IF NOT EXISTS "quiz_attempt_attempter_id_47545ab5" ON "quiz_attempt" (
	"attempter_id"
);
CREATE INDEX IF NOT EXISTS "quiz_attempt_question_id_dbb09379" ON "quiz_attempt" (
	"question_id"
);
CREATE INDEX IF NOT EXISTS "quiz_attempt_quiz_id_98ff7757" ON "quiz_attempt" (
	"quiz_id"
);
CREATE INDEX IF NOT EXISTS "page_postfilecontent_user_id_40e839bb" ON "page_postfilecontent" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "page_page_user_id_3e90c4d5" ON "page_page" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "page_page_files_page_id_postfilecontent_id_e026f43a_uniq" ON "page_page_files" (
	"page_id",
	"postfilecontent_id"
);
CREATE INDEX IF NOT EXISTS "page_page_files_page_id_ef4f7bd4" ON "page_page_files" (
	"page_id"
);
CREATE INDEX IF NOT EXISTS "page_page_files_postfilecontent_id_b1535502" ON "page_page_files" (
	"postfilecontent_id"
);
CREATE INDEX IF NOT EXISTS "module_module_user_id_23441d86" ON "module_module" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "module_module_assignments_module_id_assignment_id_119d18d4_uniq" ON "module_module_assignments" (
	"module_id",
	"assignment_id"
);
CREATE INDEX IF NOT EXISTS "module_module_assignments_module_id_c2dbfc8c" ON "module_module_assignments" (
	"module_id"
);
CREATE INDEX IF NOT EXISTS "module_module_assignments_assignment_id_d64463cb" ON "module_module_assignments" (
	"assignment_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "module_module_pages_module_id_page_id_e0d0fd4b_uniq" ON "module_module_pages" (
	"module_id",
	"page_id"
);
CREATE INDEX IF NOT EXISTS "module_module_pages_module_id_876fc287" ON "module_module_pages" (
	"module_id"
);
CREATE INDEX IF NOT EXISTS "module_module_pages_page_id_c5236a73" ON "module_module_pages" (
	"page_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "module_module_quizzes_module_id_quizzes_id_7e114a0a_uniq" ON "module_module_quizzes" (
	"module_id",
	"quizzes_id"
);
CREATE INDEX IF NOT EXISTS "module_module_quizzes_module_id_1f27544b" ON "module_module_quizzes" (
	"module_id"
);
CREATE INDEX IF NOT EXISTS "module_module_quizzes_quizzes_id_a4e460b2" ON "module_module_quizzes" (
	"quizzes_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "classroom_course_enrolled_course_id_user_id_aa8a3b9b_uniq" ON "classroom_course_enrolled" (
	"course_id",
	"user_id"
);
CREATE INDEX IF NOT EXISTS "classroom_course_enrolled_course_id_4a0d5d7c" ON "classroom_course_enrolled" (
	"course_id"
);
CREATE INDEX IF NOT EXISTS "classroom_course_enrolled_user_id_c8e0f9a2" ON "classroom_course_enrolled" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "classroom_course_modules_course_id_module_id_a9016b6a_uniq" ON "classroom_course_modules" (
	"course_id",
	"module_id"
);
CREATE INDEX IF NOT EXISTS "classroom_course_modules_course_id_28140d0c" ON "classroom_course_modules" (
	"course_id"
);
CREATE INDEX IF NOT EXISTS "classroom_course_modules_module_id_0f5129ef" ON "classroom_course_modules" (
	"module_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "classroom_course_questions_course_id_question_id_a9b0f377_uniq" ON "classroom_course_questions" (
	"course_id",
	"question_id"
);
CREATE INDEX IF NOT EXISTS "classroom_course_questions_course_id_25a1ec3e" ON "classroom_course_questions" (
	"course_id"
);
CREATE INDEX IF NOT EXISTS "classroom_course_questions_question_id_a99867cc" ON "classroom_course_questions" (
	"question_id"
);
CREATE INDEX IF NOT EXISTS "classroom_grade_course_id_5c750493" ON "classroom_grade" (
	"course_id"
);
CREATE INDEX IF NOT EXISTS "classroom_grade_graded_by_id_80ac25d7" ON "classroom_grade" (
	"graded_by_id"
);
CREATE INDEX IF NOT EXISTS "classroom_grade_submission_id_7dc90528" ON "classroom_grade" (
	"submission_id"
);
CREATE INDEX IF NOT EXISTS "completion_completion_assignment_id_0d5e1138" ON "completion_completion" (
	"assignment_id"
);
CREATE INDEX IF NOT EXISTS "completion_completion_course_id_0117bdc9" ON "completion_completion" (
	"course_id"
);
CREATE INDEX IF NOT EXISTS "completion_completion_page_id_435e8c89" ON "completion_completion" (
	"page_id"
);
CREATE INDEX IF NOT EXISTS "completion_completion_quiz_id_cce6f86e" ON "completion_completion" (
	"quiz_id"
);
CREATE INDEX IF NOT EXISTS "completion_completion_user_id_16d1a5a6" ON "completion_completion" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "direct_message_recipient_id_25d0a8b9" ON "direct_message" (
	"recipient_id"
);
CREATE INDEX IF NOT EXISTS "direct_message_sender_id_f829618e" ON "direct_message" (
	"sender_id"
);
CREATE INDEX IF NOT EXISTS "direct_message_user_id_7d660a48" ON "direct_message" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "quiz_quizzes_user_id_dabd18c4" ON "quiz_quizzes" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "django_session_expire_date_a5c62663" ON "django_session" (
	"expire_date"
);
CREATE INDEX IF NOT EXISTS "classroom_course_user_id_a05d9798" ON "classroom_course" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "classroom_course_mem_id_a5c6cdf0" ON "classroom_course" (
	"mem_id"
);
CREATE INDEX IF NOT EXISTS "livestream_livestream_recipient_id_c029fa3b" ON "livestream_livestream" (
	"recipient_id"
);
CREATE INDEX IF NOT EXISTS "livestream_livestream_sender_id_b5eca5df" ON "livestream_livestream" (
	"sender_id"
);
CREATE INDEX IF NOT EXISTS "livestream_livestream_user_id_c4fc0eae" ON "livestream_livestream" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "blog_article_title_category_id_b64bc518_uniq" ON "blog_article" (
	"title",
	"category_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "blog_course_title_article_id_e75dd3e9_uniq" ON "blog_course" (
	"title",
	"article_id"
);
COMMIT;
