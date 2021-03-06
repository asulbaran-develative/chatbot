# frozen_string_literal: true

# servicio paras consultar
module ChatRequest
  PERMIT = { 'greetings' => ['menu'],
             'menu' => %w[1 2 3],
             'check_deposit' => [],
             'consult_economic_indicators' => %w[cpt utm uf] }.freeze
  TRANSITION = { 'greetings' => ['menu!'],
                 'menu' => ['check_deposit!', 'paper_rolls_request!',
                            'consult_economic_indicators!'],
                 'consult_economic_indicators' => ['cpt!', 'utm!', 'uf!'] }.freeze
  MENU_OPTIONS = ['1.- Consulta de Depósito',
                  '2.- Realizar Solicitud Rollos de Papel',
                  '3.- Consulta Indicadores Económicos'].freeze
  RESPONSE = { 'greetings' => 'Hola, soy el un bot muy '\
                              'joven y aun no tengo muchas opciones programadas. <br>'\
                              'Puedes enviarme la palabra "menu" para darle las '\
                              'opciones disponibles.',
               'menu' => "Por favor escoja una opción: <br> #{MENU_OPTIONS.join('<br>')} ",
               'check_deposit' => '<strong>Seleccionó Consulta de Depósito.</strong> <br>'\
                                  'Por favor ingrese Rut y Fecha, <br>'\
                                  'Ejemplo: 123456<strong>/</strong>01-10-2021 <br>'\
                                  'Es importante que el formato de la fecha sea '\
                                  'dd-mm-yyyy, es decir dia-mes-año y el separador '\
                                  'entre Rut y Feha debe ser un <strong>/</strong>',
               'paper_rolls_request' => '<strong>Seleccionó Solicitud Rollos de Papel. </strong> <br>'\
                                        'Por favor ingrese Rut, dirección de despacho '\
                                        'y la cantidad de rollos <br>'\
                                        'Ejemplo: 1233466<strong>/</strong>Santiago de chile<strong>/</strong>2 <br>'\
                                        'En este ejemplo el primer bloque es el Rut '\
                                        'el segundo es la direccion y el (2) la cantidad '\
                                        'de rollos a solicitar <br>'\
                                        'El separador entre Rut, Direccion y Cantidad debe '\
                                        'ser un <strong>/</strong>',
               'consult_economic_indicators' => '<strong>Seleccionó Consulta Indicadores Económicos. </strong><br>'\
                                                 'Por favor ingrese que desea consultar: '\
                                                 'Las opciones son: <br>'\
                                                 '<strong>UF</strong> = Unidad de fomento.<br>'\
                                                 '<strong>UTM</strong> = Unidad Tributaria Mensual.<br>'\
                                                 '<strong>CPT</strong> = USD, UTM y UF.',
               'utm' => Chile::EconomicIndicators::Indicator.show[:utm],
               'uf' => Chile::EconomicIndicators::Indicator.show[:uf],
               'cpt' => Chile::EconomicIndicators::Indicator.show[:text] }.freeze

  # Obtener respuestas segun estado menu
  class State
    # rubocop:disable Metrics/AbcSize
    def self.show(current_user, message)
      current_chat = current_user.chat.last
      search_permit = search_local_permit(current_chat, message)

      if search_permit.present?
        last_state = current_chat.state
        trans = TRANSITION.dig(last_state, search_permit)
        transition_state(current_chat, trans)
      elsif menu?(current_chat, message)
        transition_state(current_chat, 'menu!')
      elsif deposit?(message)
        return CustomersServices::Deposits.show(message) if current_chat.state =~ /check_deposit/
      elsif paper_rolls_request?(message)
        return CustomersServices::SalesPaper.buy(message) if current_chat.state =~ /paper_rolls_request/
      end

      RESPONSE[current_chat.state]
    end

    def self.search_local_permit(current_chat, message)
      permits = PERMIT[current_chat.state]
      permits&.find_index { |p| p.include?(message.downcase) }
    end

    def self.menu?(current_chat, message)
      current_chat.state != 'menu' && message =~ /menu/i
    end

    def self.deposit?(message)
      message =~ %r{\d{8}-[A-Z, 0-9]/\d{2}-\d{2}-\d{4}}
    end

    def self.paper_rolls_request?(message)
      message =~ %r{\d{8}-[A-Za-z, 0-9]/\w.*\w/\d{1,2}}
    end

    def self.transition_state(chat, trans)
      chat.send(trans) if trans.present?
    end
  end
  # rubocop:enable Metrics/AbcSize
end
