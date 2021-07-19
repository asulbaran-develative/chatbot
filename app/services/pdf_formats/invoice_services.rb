# frozen_string_literal: true

module PdfFormats
  # Servicio paras generar string para una factura
  class InvoiceServices
    # rubocop:disable Metrics/MethodLength
    def self.data(invoice)
      total_invoice = invoice.amount * invoice.quantity
      "<h1 style='margin-left: 70%'>Factura # #{invoice.id}</h1><br>"\
      "<label><strong>Cliente:</strong></label> #{invoice.customer.name} #{invoice.customer.last_name}<br>"\
      "<label><strong>RUT:</strong></label> #{invoice.customer.rut}<br>"\
      "<label><strong>Direccion:</strong></label> #{invoice.delivery_address}<br>"\
      '<br>'\
      '<table class="table table-bordered">'\
      '  <thead>'\
      '    <tr>'\
      '      <th style="width: 50%;text-align: left;">Detalle del producto</th>'\
      '      <th style="width: 12%;text-align: center;">Cantidad</th>'\
      '      <th style="width: 12%;text-align: right;">Precio Und</th>'\
      '      <th style="width: 16%;text-align: right;">Sub-Total</th>'\
      '    </tr>'\
      '  </thead>'\
      '  <tbody style="border-bottom: 5px solid">'\
      '    <tr>'\
      "      <td>#{invoice.description}</td>"\
      "      <td style='text-align: center;'>#{invoice.quantity}</td>"\
      "      <td style='text-align: right;'>#{invoice.amount}</td>"\
      "      <td style='text-align: right;'>#{total_invoice}</td>"\
      '    </tr>'\
      '    <tr>'\
      '      <td colspan="2"></td>'\
      '      <td style="text-align: right;">Impuesto</td>'\
      '      <td style="text-align: right;">0</td>'\
      '    </tr>'\
      '    <tr>'\
      '      <td colspan="2"></td>'\
      '      <td style="text-align: right;">Total</td>'\
      "      <td style='text-align: right'>#{total_invoice}</td>"\
      '    </tr>'\
      '  </tbody>'\
      '</table>'
    end
    # rubocop:enable Metrics/MethodLength
  end
end
