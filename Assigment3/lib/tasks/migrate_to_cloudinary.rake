# frozen_string_literal: true

# lib/tasks/migrate_to_cloudinary.rake
namespace :active_storage do
  desc 'Re-upload all existing ActiveStorage files to Cloudinary'
  task migrate_to_cloudinary: :environment do
    ActiveStorage::Blob.find_each do |blob|
      next if blob.service_name == 'cloudinary'

      puts "Migrating blob #{blob.id} (#{blob.filename})..."

      # Download the file from current storage
      file = blob.download

      # Re-upload to Cloudinary
      new_blob = ActiveStorage::Blob.create_and_upload!(
        io: StringIO.new(file),
        filename: blob.filename,
        content_type: blob.content_type,
        metadata: blob.metadata
      )

      # Replace all attachments pointing to the old blob
      blob.attachments.each do |attachment|
        attachment.update!(blob: new_blob)
      end

      puts " → Done: #{blob.filename}"
    end
  end
end
