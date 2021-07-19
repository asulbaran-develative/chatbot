# frozen_string_literal: true

# Servicio paras consultar
class InvoiceService
  # Servicio para generar factura
  def self.generate(invoice)
    # Create a pdf from a string
    body = PdfFormats::InvoiceServices.data(invoice)
    file_name = "factura_#{invoice.id}.pdf"
    pdf = WickedPdf.new.pdf_from_string(body)
    FileUtils.mkpath Rails.root.join('public/pdfs/invoices')
    File.open(Rails.root.join('public/pdfs/invoices', file_name), 'wb') { |file| file << pdf }

    "/pdfs/invoices/#{file_name}"
  rescue StandardError
    'No se pudo generar pdf, consulte con soporte tecnico.'
  end
end
