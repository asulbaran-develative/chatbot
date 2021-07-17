# frozen_string_literal: true

# servicio paras consultar depositos
module CustomersServices
  # obtener depositos
  class Deposits
    def self.show(data)
      rut, date = data.split('/')
      return 'Fecha no valida.' unless validate_date(date)

      customer = Customer.find_by(rut: rut)
      return 'Rut invalido' unless customer.present?

      deposits = customer.deposits.where(date_of_process: date.to_time.all_day)
      return 'No hay depositos con la fecha ingresada' unless deposits.present?

      response_text(deposits)
    end

    def self.response_text(deposits)
      message = ''
      deposits.each do |deposit|
        deposit_date = deposit.date_of_process.strftime('%d/%m/%Y')
        message += "Descripción: #{deposit.description} / "\
                   "Fecha: #{deposit_date} / Monto: #{deposit.amount} <br>"
      end
      message
    end

    def self.validate_date(date)
      Date.parse(date)
    rescue ArgumentError
      false
    end
  end
end
