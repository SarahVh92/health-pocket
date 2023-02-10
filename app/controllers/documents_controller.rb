class DocumentsController < ApplicationController
  def index
    @documents = policy_scope(Document)
  end
end
