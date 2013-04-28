module InsalesApi
  class Charge < Base
    def self.status
      Hash.from_xml connection.get('/admin/recurring_application_charge.xml').body
    end

    def self.setup price
      xml = {monthly: BigDecimal.new(price)}.to_xml(root: :recurring_application_charge)
      connection.post('/admin/recurring_application_charge.xml', xml, headers)
    end

  end
end
