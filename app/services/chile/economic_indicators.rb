# frozen_string_literal: true

# Servicio paras consultar indicadores
module Chile
  module EconomicIndicators
    # Obtener indicadores
    class Indicator
      def self.show
        uri = URI(ENV['url_api_indicators_chile'])
        response = Net::HTTP.get_response(uri)

        if response.code.to_i == 200
          response_data(response)
        else
          status_error(400)
        end
      rescue StandardError
        status_error(500)
      end

      def self.response_data(response)
        body_parse = JSON.parse(response.body)
        usd = body_parse['dolar']['valor']
        utm = body_parse['utm']['valor']
        uf = body_parse['uf']['valor']

        {
          status: 'OK',
          code: 200,
          text: "<strong>USD<strong>: #{usd}, "\
                "<strong>UTM:</strong> #{utm}, "\
                "<strong>UF:</strong> #{uf}",
          utm: "<strong>UTM:</strong> #{utm}",
          uf: "<strong>UF:</strong> #{uf}"
        }
      rescue JSON::ParserError
        status_error(500)
      end

      def self.status_error(code)
        {
          status: 'FAILED',
          code: code,
          text: 'Valores no dispobible por el momento'
        }
      end
    end
  end
end
