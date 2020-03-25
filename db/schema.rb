# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_200_318_152_045) do
  create_table 'admins', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_admins_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_admins_on_reset_password_token', unique: true
  end

  create_table 'comments', force: :cascade do |t|
    t.string 'content'
    t.integer 'user_id'
    t.integer 'event_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['event_id'], name: 'index_comments_on_event_id'
    t.index ['user_id'], name: 'index_comments_on_user_id'
  end

  create_table 'events', force: :cascade do |t|
    t.string 'title'
    t.text 'content'
    t.datetime 'start_time'
    t.integer 'prefecture'
    t.string 'address'
    t.string 'image'
    t.float 'latitude'
    t.float 'longitude'
    t.integer 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_events_on_user_id'
  end

  create_table 'join_users', force: :cascade do |t|
    t.integer 'event_id'
    t.integer 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['event_id'], name: 'index_join_users_on_event_id'
    t.index ['user_id'], name: 'index_join_users_on_user_id'
  end

  create_table 'likes', force: :cascade do |t|
    t.integer 'event_id'
    t.integer 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['event_id'], name: 'index_likes_on_event_id'
    t.index ['user_id'], name: 'index_likes_on_user_id'
  end

  create_table 'notifications', force: :cascade do |t|
    t.integer 'visitor_id', null: false
    t.integer 'visited_id', null: false
    t.integer 'event_id'
    t.integer 'comment_id'
    t.string 'action', default: '', null: false
    t.boolean 'checked', default: false, null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['comment_id'], name: 'index_notifications_on_comment_id'
    t.index ['event_id'], name: 'index_notifications_on_event_id'
    t.index ['visited_id'], name: 'index_notifications_on_visited_id'
    t.index ['visitor_id'], name: 'index_notifications_on_visitor_id'
  end

  create_table 'relationships', force: :cascade do |t|
    t.integer 'follower_id'
    t.integer 'followed_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['followed_id'], name: 'index_relationships_on_followed_id'
    t.index %w[follower_id followed_id], name: 'index_relationships_on_follower_id_and_followed_id', unique: true
    t.index ['follower_id'], name: 'index_relationships_on_follower_id'
  end

  create_table 'taggings', force: :cascade do |t|
    t.integer 'tag_id'
    t.string 'taggable_type'
    t.integer 'taggable_id'
    t.string 'tagger_type'
    t.integer 'tagger_id'
    t.string 'context', limit: 128
    t.datetime 'created_at'
    t.index ['context'], name: 'index_taggings_on_context'
    t.index %w[tag_id taggable_id taggable_type context tagger_id tagger_type], name: 'taggings_idx', unique: true
    t.index ['tag_id'], name: 'index_taggings_on_tag_id'
    t.index %w[taggable_id taggable_type context], name: 'taggings_taggable_context_idx'
    t.index %w[taggable_id taggable_type tagger_id context], name: 'taggings_idy'
    t.index ['taggable_id'], name: 'index_taggings_on_taggable_id'
    t.index ['taggable_type'], name: 'index_taggings_on_taggable_type'
    t.index %w[tagger_id tagger_type], name: 'index_taggings_on_tagger_id_and_tagger_type'
    t.index ['tagger_id'], name: 'index_taggings_on_tagger_id'
  end

  create_table 'tags', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.integer 'taggings_count', default: 0
    t.index ['name'], name: 'index_tags_on_name', unique: true
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.string 'username', null: false
    t.string 'lastname', null: false
    t.string 'firstname', null: false
    t.string 'kana_lastname', null: false
    t.string 'kana_firstname', null: false
    t.string 'area'
    t.string 'image'
    t.float 'latitude'
    t.float 'longitude'
    t.boolean 'status'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end
end
