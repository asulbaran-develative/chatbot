# frozen_string_literal: true

# servicio paras la compra de rollos de papel
module CustomersServices
  # obtener depositos
  class SalesPaper
    def self.buy(data)
      rut, address, quantity = data.split('/')
      return 'Monto invalido.<br>' if quantity.to_i.zero?

      customer = Customer.find_by(rut: rut)
      return 'Rut invalido.<br>' unless customer.present?

      amount = (700 * quantity.to_i)
      deposits = customer.deposits.where(date_of_process: (Time.now + 1.day).all_day)
      return 'Saldo insuficiente.<br>' if balance?(deposits, amount)

      generate_invoice(customer, quantity, amount, address)
    end

    def self.generate_invoice(customer, quantity, amount, address)
      customer.invoices.create(quantity: quantity, description: 'Rollo de papel',
                               amount: amount, delivery_address: address)
      'Pedido realizado.<br>'\
      "#{quantity} Rollos de Papel, Monto UND: 700 "\
      "Total del pedido:  #{amount}"
    end

    def self.balance?(deposits, amount)
      (deposits.present? && deposits.sum(:amount) >= amount.to_f)
    end
  end
end
