<template>
    <div class="operator-card">
      <div class="card-header">
        <h3>{{ operator.Razao_Social }}</h3>
        <span class="relevance" :title="'Relevância: ' + operator.Relevancia + '%'">
          {{ operator.Relevancia }}%
        </span>
      </div>
      
      <div class="card-body">
        <p v-if="operator.Nome_Fantasia">
          <strong>Nome Fantasia:</strong> {{ operator.Nome_Fantasia }}
        </p>
        
        <div class="card-details">
          <div class="detail-item">
            <span class="detail-label">Registro ANS:</span>
            <span class="detail-value">{{ operator.Registro_ANS }}</span>
          </div>
          
          <div class="detail-item">
            <span class="detail-label">CNPJ:</span>
            <span class="detail-value">{{ formatCNPJ(operator.CNPJ) }}</span>
          </div>
          
          <div class="detail-item">
            <span class="detail-label">Modalidade:</span>
            <span class="detail-value">{{ operator.Modalidade }}</span>
          </div>
          
          <div class="detail-item">
            <span class="detail-label">Localização:</span>
            <span class="detail-value">{{ operator.Cidade }}/{{ operator.UF }}</span>
          </div>
          
          <div class="detail-item">
            <span class="detail-label">Cadastro em:</span>
            <span class="detail-value">{{ formatDate(operator.Data_Registro_ANS) }}</span>
          </div>
        </div>
      </div>
    </div>
  </template>
  
  <script>
  export default {
    name: 'OperatorCard',
    props: {
      operator: {
        type: Object,
        required: true
      }
    },
    methods: {
      formatCNPJ(cnpj) {
        if (!cnpj) return ''
        return cnpj.replace(/^(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})$/, '$1.$2.$3/$4-$5')
      },
      formatDate(dateString) {
        if (!dateString) return ''
        const date = new Date(dateString)
        return date.toLocaleDateString('pt-BR')
      }
    }
  }
  </script>
  
  <style scoped>
  .operator-card {
    background-color: white;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    overflow: hidden;
    transition: transform 0.3s, box-shadow 0.3s;
  }
  
  .operator-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
  }
  
  .card-header {
    background-color: var(--primary-color);
    color: white;
    padding: 1rem;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  
  .card-header h3 {
    font-size: 1.1rem;
    margin: 0;
  }
  
  .relevance {
    background-color: var(--secondary-color);
    padding: 0.25rem 0.5rem;
    border-radius: 20px;
    font-size: 0.8rem;
    font-weight: bold;
  }
  
  .card-body {
    padding: 1rem;
  }
  
  .card-details {
    margin-top: 1rem;
  }
  
  .detail-item {
    display: flex;
    margin-bottom: 0.5rem;
    font-size: 0.9rem;
  }
  
  .detail-label {
    font-weight: bold;
    min-width: 100px;
    color: #555;
  }
  
  .detail-value {
    flex: 1;
  }
  </style>