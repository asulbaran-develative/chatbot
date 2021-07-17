# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
cm1 = Customer.create(rut: '123456789-A', name: 'Pedro', last_name: 'Perez',
                      address: 'Calle 40, Santia de Chile', phone: '+567861505',
                      balance: 0, state: 'Activo')
cm2 = Customer.create(rut: '123456789-B', name: 'Juan', last_name: 'Perez',
                      address: 'Calle 45, Santia de Chile', phone: '+567861506',
                      balance: 0, state: 'Activo')
cm3 = Customer.create(rut: '123456789-C', name: 'Maria', last_name: 'Perez',
                      address: 'Calle 47, Santia de Chile', phone: '+567861507',
                      balance: 0, state: 'Activo')

cm1.deposit.create(description: 'Comisiones por ventas', amount: 120_000,
                   date_of_process: Time.now, state: 'Pendiente')
cm2.deposit.create(description: 'Comisiones por ventas', amount: 220_000,
                   date_of_process: (Time.now + 1.day), state: 'Pendiente')
cm3.deposit.create(description: 'Comisiones por ventas', amount: 500,
                   date_of_process: (Time.now + 1.day), state: 'Pendiente')
