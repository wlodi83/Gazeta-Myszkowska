class AttachmentsController < ApplicationController
    def destroy
        @attachment = Attachment.find(params[:id])
        @attachment.destroy
        asset = @attachment.attachable
        @allowed = 5 - asset.attachments.count
  end
end
