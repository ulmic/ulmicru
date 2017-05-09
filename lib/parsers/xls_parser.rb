require 'roo'

module XlsParser
  class << self
    def first_sheet_collection(file)
      Roo::Spreadsheet.open(file, extension: :xlsx).sheet(0).to_a
    end
  end
end
