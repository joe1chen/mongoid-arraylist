require 'spec_helper'

class Post
  include Mongoid::Document
  include Mongoid::ArrayList

  field :tags, type: Array, default: []

  list_field :tags
end

module Mongoid::ArrayList
  describe "list_field" do
    context "class methods" do

      subject { Post }

      it { should respond_to(:list_field) }
    end

    context "instance methods" do
      subject { Post.new }

      it { should respond_to(:tags_list) }
      it { should respond_to(:tags_list=) }
    end

    it 'should set tags from tags_list=' do
      post = Post.create!
      post.tags_list = 'tag1, tag2, tag3'
      post.save!

      expect(post.tags).to match_array(['tag1', 'tag2', 'tag3'])
    end

    it 'should get tags from tags_list' do
      post = Post.create!
      post.tags = ['tag1', 'tag2', 'tag3']
      post.save!

      expect(post.tags_list).to eq('tag1, tag2, tag3')
    end
  end
end