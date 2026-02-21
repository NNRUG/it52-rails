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
      next if (user.interested_category_ids - category_ids).empty? && (category_ids - user.interested_category_ids).empty?

      user.interested_category_ids = category_ids
      user.save!
      updated += 1
    end
    puts "Готово. Обновлено пользователей: #{updated}."
  end
end
