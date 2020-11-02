module AccountingModule
  class EntryPosting
    attr_reader :voucher

    def initialize(args={})
      @voucher = args.fetch(:voucher)
    end
    def post_entry!
      ApplicationRecord.transaction do
        create_entry!
      end
    end

    private
    def create_entry!

    end
  end
end
