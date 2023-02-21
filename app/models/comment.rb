class Comment < ApplicationRecord
  belongs_to :user, :foreign_key => :author_id
  belongs_to :post
  
  include ActionView::RecordIdentifier

  after_create_commit do 
    broadcast_append_to [post, :comments], target: dom_id(post, :comments), partial: "comments/comment", locals: { comment: self }
    # broadcast_prepend_to [inbox, :messages], target: ActionView::RecordIdentifier.dom_id(inbox, :messages)
  end
end
