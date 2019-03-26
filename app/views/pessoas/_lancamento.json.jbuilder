json.extract! lancamento, :id, :descricao, :data_vencimento, :data_pagamento, :valor, :observacao, :categoria_id, :created_at, :updated_at
json.url lancamento_url(lancamento, format: :json)
