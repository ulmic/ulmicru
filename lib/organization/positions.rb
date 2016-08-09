module Organization
  module Positions
    def order_positions(positions)
      order = YAML.load_file("#{Rails.root}/lib/yaml/positions.yml").with_indifferent_access[:order]
      positions.sort_by { |p| order.include?(p) ? [order.index(p), p] : [order.index(p.split(' ')[0]), p] }
    end
  end
end
