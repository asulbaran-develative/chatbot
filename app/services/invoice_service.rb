# frozen_string_literal: true

# servicio paras consultar
class InvoiceService
  # servicio para generar factura
  def self.generate(invoice)
    # create a pdf from a string
    body = PdfFormats::InvoiceServices.data(invoice)
    file_name = "factura_#{invoice.id}.pdf"
    pdf = WickedPdf.new.pdf_from_string(body)
    FileUtils.mkpath Rails.root.join('public/pdfs/invoices')
    save_path = Rails.root.join('public/pdfs/invoices', file_name)
    File.open(save_path, 'wb') do |file|
      file << pdf
    end
    "/pdfs/invoices/#{file_name}"
  rescue StandardError => _e
    'No se pudo generar pdf, consulte con soporte tecnico.'
  end
end
