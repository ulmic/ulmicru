module Organization
  module Teams
    def presidium
      Team.find_by_title 'Президиум'
    end

    def area_headers
      Team.find_by_title 'Руководители областных программ и проектов МИЦ'
    end
  end
end
