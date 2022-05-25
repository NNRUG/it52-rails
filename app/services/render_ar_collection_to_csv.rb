# frozen_string_literal: true

require 'csv'

class RenderArCollectionToCsv
  def self.perform(collection, column_names = nil, options = {})
    column_names ||= collection.table_name.singularize.capitalize.constantize.column_names

    CSV.generate(options) do |csv|
      csv << column_names
      collection.each do |collection_item|
        csv << column_names.map { |method_name| collection_item.send(method_name) }
      end
    end
  end
end
