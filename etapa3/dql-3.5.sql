SELECT 
    dc.registro_operadora,
    oa.razao_social,
    dc.saldo_final AS despesa
FROM DEMONSTRACOES_CONTABEIS dc
JOIN OPERADORAS_ATIVAS oa ON dc.registro_operadora = oa.registro_operadora
WHERE dc.descricao = 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR'
  AND dc.data_trimestre = (
      SELECT MAX(data_trimestre)
      FROM DEMONSTRACOES_CONTABEIS
      WHERE descricao = 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR'
  )
ORDER BY dc.saldo_final DESC
LIMIT 10;