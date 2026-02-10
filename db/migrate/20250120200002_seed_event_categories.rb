# frozen_string_literal: true

class SeedEventCategories < ActiveRecord::Migration[5.2]
  CATEGORY_NAMES = [
    'Маркетинг',
    'Менеджмент',
    'Дизайн UI|UX',
    'Разработка',
    'Softskills',
    'HR',
    'DevRel',
    'DevOps',
    'SRE',
    'Cloud',
    'Data Science',
    'BigData',
    'Security',
    'SecOps',
    'Product Managment',
    'QA',
    'SW Testing',
    'Test Automation',
    'SDET',
    'ML|AI',
    'IoT',
    'Backend',
    'FrontEnd',
    'Mobile',
    'Системный Анализ',
    'Бизнес Анализ',
    'Карьера',
    'Pentest',
    'Defcon'
  ].freeze

  def up
    CATEGORY_NAMES.each { |name| Category.find_or_create_by!(name: name) }
  end

  def down
    Category.where(name: CATEGORY_NAMES).destroy_all
  end
end
