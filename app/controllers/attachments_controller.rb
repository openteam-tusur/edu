# encoding: utf-8

class AttachmentsController < ApplicationController
  check_authorization

  def download
    head(:not_found) and return if (attachment = Attachment.find(params[:id].split("-")[0])).nil?

    authorize! :download, attachment

    send_file_options = { :type => attachment.data.content_type }
    send_file(attachment.data.path, send_file_options)
  end
end
