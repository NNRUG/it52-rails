# frozen_string_literal: true

namespace :users do
  desc 'Выставить всем пользователям все категории по умолчанию (подписка на все категории)'
  task set_all_categories: :environment do
    category_ids = Category.pluck(:id)
    if category_ids.empty?
      puts 'Нет категорий в базе. Создайте категории и запустите задачу снова.'
      next
    end

    updated = 0
    User.find_each do |user|
      existing_ids = user.user_categories.pluck(:category_id)
      next if (existing_ids - category_ids).empty? && (category_ids - existing_ids).empty?

      user.user_categories.where.not(category_id: category_ids).delete_all
      (category_ids - existing_ids).each do |category_id|
        user.user_categories.find_or_create_by!(category_id: category_id)
      end
      updated += 1
    end
    puts "Готово. Обновлено пользователей: #{updated}."
  end
end
