class LineItemTypes
  class Component
    attr_reader :id, :miles_life, :months_life

    def initialize(yaml)
      @yaml = yaml
      @id = yaml["id"]
      @name = yaml["name"]
      @miles_life = yaml["milesLife"]
      @months_life = yaml["monthsLife"]
    end

    def inspect
      "<Component #{id}>"
    end
  end

  class Category
    attr_reader :parent, :id, :icon

    def initialize(yaml, parent = nil)
      @yaml = yaml
      @parent = parent
      @id = yaml["id"]
      @icon = yaml["icon"]
      @subcategories_yaml = yaml["subcategories"]
      @types_yaml = yaml["types"]
    end

    def subcategories!
      (@subcategories_yaml || []).map { |yaml| LineItemTypes::Category.new(yaml, self) }
    end

    def subcategories
      @subcategories ||= subcategories!
    end

    def types!
      (@types_yaml || []).map { |yaml| LineItemTypes::Type.new(yaml, self) }
    end

    def types
      @types ||= types!
    end

    def display_name_key
      "line_item_types.categories.#{id}.name"
    end

    def display_name
      I18n.t display_name_key
    end

    def inspect
      "<Category #{id}>"
    end
  end

  class Type
    attr_reader :id, :category, :replaces, :icon

    def initialize(yaml, category)
      @yaml = yaml
      @id = yaml["id"]
      @category = category
      @replaces = yaml["replaces"]
      @icon = yaml["icon"]
      @fields_yaml = yaml["fields"]
      @display_name = yaml["displayName"]
    end

    def fields!
      (@fields_yaml || []).map { |yaml| LineItemTypes::Field.new(yaml, self) }
    end

    def fields
      @fields ||= fields!
    end

    def fields_by_id!
      hash = {}
      fields.each do |field|
        hash[field.id] = field
      end
      hash
    end

    def fields_by_id
      @fields_by_id ||= fields_by_id!
    end

    def get_field(id)
      fields_by_id[id]
    end

    def display_name_key
      "line_item_types.types.#{id}.name"
    end

    def display_name
      I18n.t display_name_key
    end

    def description_key
      "line_item_types.types.#{id}.description"
    end

    def description
      if I18n.exists? description_key then
        I18n.t description_key
      end
    end

    def inspect
      "<Type #{id}>"
    end
  end

  class Field
    attr_reader :parent, :id, :type, :enum_values, :example, :default_value, :default_value_from, :unit

    def initialize(yaml, parent)
      @yaml = yaml
      @parent = parent
      @id = yaml["id"]
      @type = yaml["type"]
      @enum_values = yaml["enumValues"]&.map { |yaml| yaml["id"] }
      @example = yaml["example"]
      @default_value = yaml["defaultValue"]
      @default_value_from = yaml["defaultValueFrom"]
      @unit = yaml["unit"]
    end

    def short_display_name_key
      "line_item_types.types.#{parent.id}.fields.#{id}.short_name"
    end

    def short_display_name
      I18n.t short_display_name_key
    end

    def display_name_key
      "line_item_types.types.#{parent.id}.fields.#{id}.name"
    end

    def display_name
      I18n.t display_name_key, fallback: short_display_name
    end

    def inspect
      "<Field #{id}>"
    end
  end

  def initialize(file_name = File.join(__dir__, "line_item_types", "line_item_types.yml"))
    @file_name = file_name
  end

  def file_name
    @file_name
  end

  def file_contents!
    YAML.load_file(file_name)
  end

  def file_contents
    @file_contents ||= file_contents!
  end

  def components!
    file_contents["components"].map { |yaml| LineItemTypes::Component.new yaml }
  end

  def components
    @components ||= components!
  end
  
  def components_by_id!
    hash = {}
    components.each do |component|
      hash[component.id] = component
    end
    hash
  end

  def components_by_id
    @components_by_id ||= components_by_id!
  end

  def get_component(id)
    components_by_id[id]
  end

  def top_level_categories!
    file_contents["categories"].map { |yaml| LineItemTypes::Category.new yaml }
  end

  def top_level_categories
    @top_level_categories ||= top_level_categories!
  end

  def all_categories!
    seen = []
    categories = top_level_categories.clone
    while !categories.empty?
      category = categories.pop
      seen.push category
      category.subcategories.each { |subcat| categories.push subcat }
    end
    seen
  end

  def all_categories
    @all_categories ||= all_categories!
  end

  def all_categories_by_id!
    hash = {}
    all_categories.each do |category|
      hash[category.id] = category
    end
    hash
  end

  def all_categories_by_id
    @all_categories_by_id ||= all_categories_by_id!
  end

  def get_category(id)
    all_categories_by_id[id]
  end

  def all_types!
    seen = []
    all_categories.each do |category|
      seen += category.types
    end
    seen
  end

  def all_types
    @all_types ||= all_types!
  end

  def all_types_by_id!
    hash = {}
    all_types.each do |type|
      hash[type.id] = type
    end
    hash
  end

  def all_types_by_id
    @all_types_by_id ||= all_types_by_id!
  end

  def get_type(id)
    all_types_by_id[id]
  end

  GLOBAL = LineItemTypes.new
end
