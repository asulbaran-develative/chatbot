# frozen_string_literal: true

# Servicio paras la compra de rollos de papel
module CustomersServices
  # Obtener depositos
  class SalesPaper
    def self.buy(data)
      rut, address, quantity = data.split('/')
      return 'Monto invalido.<br>' if quantity.to_i.zero?

      customer = Customer.find_by(rut: rut)
      return 'Rut invalido.<br>' unless customer.present?

      amount = (700 * quantity.to_i)
      deposits = customer.deposits.where(date_of_process: (Time.now + 1.day).all_day)
      return 'Saldo insuficiente.<br>' unless balance?(deposits, amount)

      generate_invoice(customer, quantity, amount, address)
    end

    def self.generate_invoice(customer, quantity, amount, address)
      inv = customer.invoices.create(
        quantity: quantity, description: 'Rollo de papel',
        amount: amount, delivery_address: address
      )
      invoice_link = InvoiceService.generate(inv)

      '<strong>Pedido realizado.</strong><br>'\
      "#{quantity} Rollos de Papel, Monto UND: 700 "\
      "Total del pedido:  #{amount}<br>"\
      '<strong>Puede descarcar la factura aqui:</strong><br>'\
      "<a href='#{invoice_link}' download>"\
      "#{invoice_link.split('/').last.upcase}</a>"
    end

    def self.balance?(deposits, amount)
      (deposits.present? && deposits.sum(:amount) >= amount.to_f)
    end
  end
end
