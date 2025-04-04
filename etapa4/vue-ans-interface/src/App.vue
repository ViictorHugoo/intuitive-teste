<template>
    <div class="app-container">
      <header class="app-header">
        <h1>Busca de Operadoras de Saúde</h1>
        <p class="subtitle">Consulte o cadastro de operadoras da ANS</p>
      </header>
  
      <main class="app-main">
        <div class="search-container">
          <div class="search-box">
            <input
              type="text"
              v-model="searchTerm"
              @keyup.enter="searchOperators"
              placeholder="Digite um termo de busca (nome, cidade, UF...)"
            />
            <button @click="searchOperators" :disabled="isLoading">
              {{ isLoading ? 'Buscando...' : 'Buscar' }}
            </button>
          </div>
  
          <div class="results-info" v-if="results.length > 0">
            <p>{{ results.length }} resultados encontrados</p>
            <select v-model="resultsLimit" @change="searchOperators">
              <option value="5">5 resultados</option>
              <option value="10">10 resultados</option>
              <option value="20">20 resultados</option>
              <option value="50">50 resultados</option>
            </select>
          </div>
        </div>
  
        <div class="results-container">
          <div v-if="isLoading" class="loading">
            <div class="spinner"></div>
            <p>Carregando resultados...</p>
          </div>
  
          <div v-else-if="error" class="error-message">
            <p>{{ error }}</p>
          </div>
  
          <div v-else-if="results.length === 0 && searchPerformed" class="no-results">
            <p>Nenhum resultado encontrado para "{{ lastSearchTerm }}"</p>
          </div>
  
          <div v-else class="results-grid">
            <OperatorCard
              v-for="operator in results"
              :key="operator.Registro_ANS"
              :operator="operator"
            />
          </div>
        </div>
      </main>
  
      <footer class="app-footer">
        <p>Dados do Cadastro Nacional de Operadoras da ANS</p>
      </footer>
    </div>
  </template>
  
  <script>
  import OperatorCard from './components/operatorCard.vue'
  import axios from 'axios'
  
  export default {
    name: 'App',
    components: {
      OperatorCard
    },
    data() {
      return {
        searchTerm: '',
        results: [],
        isLoading: false,
        error: null,
        searchPerformed: false,
        lastSearchTerm: '',
        resultsLimit: 10,
        apiUrl: 'http:///buscar' // Ajuste conforme necessário
      }
    },
    methods: {
      async searchOperators() {
        if (!this.searchTerm.trim()) {
          this.error = 'Por favor, digite um termo para buscar'
          return
        }

        this.isLoading = true
        this.error = null
        this.lastSearchTerm = this.searchTerm

        try {
          const response = await axios.get(this.apiUrl, {
            params: {
              termo: this.searchTerm,
              limite: this.resultsLimit
            },
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json'
            },
            withCredentials: false  // Importante para evitar problemas com CORS
          })
          
          if (response.data) {
            this.results = response.data
          } else {
            this.error = 'Resposta inesperada da API'
          }
          
          this.searchPerformed = true
        } catch (err) {
          console.error('Erro na busca:', err)
          this.error = 'Não foi possível conectar ao servidor. Verifique sua conexão.'
          if (err.response) {
            this.error = `Erro ${err.response.status}: ${err.response.data.error || 'Erro desconhecido'}`
          }
          this.results = []
        } finally {
          this.isLoading = false
        }
      }
    }
  }
  </script>
  
  <style>
  /* Estilos globais */
  :root {
    --primary-color: #2c3e50;
    --secondary-color: #42b983;
    --light-color: #f8f9fa;
    --dark-color: #343a40;
    --border-color: #dee2e6;
    --error-color: #dc3545;
  }
  
  * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
  }
  
  body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    line-height: 1.6;
    color: var(--dark-color);
    background-color: #f5f5f5;
  }
  
  .app-container {
    min-height: 100vh;
    display: flex;
    flex-direction: column;
  }
  
  .app-header {
    background-color: var(--primary-color);
    color: white;
    padding: 2rem 1rem;
    text-align: center;
  }
  
  .app-header h1 {
    font-size: 2rem;
    margin-bottom: 0.5rem;
  }
  
  .subtitle {
    font-size: 1rem;
    opacity: 0.8;
  }
  
  .app-main {
    flex: 1;
    padding: 2rem 1rem;
    max-width: 1200px;
    margin: 0 auto;
    width: 100%;
  }
  
  .search-container {
    margin-bottom: 2rem;
  }
  
  .search-box {
    display: flex;
    gap: 0.5rem;
    margin-bottom: 1rem;
  }
  
  .search-box input {
    flex: 1;
    padding: 0.75rem 1rem;
    border: 1px solid var(--border-color);
    border-radius: 4px;
    font-size: 1rem;
  }
  
  .search-box button {
    padding: 0.75rem 1.5rem;
    background-color: var(--secondary-color);
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 1rem;
    transition: background-color 0.3s;
  }
  
  .search-box button:hover {
    background-color: #3aa876;
  }
  
  .search-box button:disabled {
    background-color: #cccccc;
    cursor: not-allowed;
  }
  
  .results-info {
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-size: 0.9rem;
    color: #666;
  }
  
  .results-info select {
    padding: 0.3rem 0.5rem;
    border-radius: 4px;
    border: 1px solid var(--border-color);
  }
  
  .results-container {
    min-height: 300px;
  }
  
  .loading {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    padding: 2rem;
  }
  
  .spinner {
    width: 40px;
    height: 40px;
    border: 4px solid rgba(0, 0, 0, 0.1);
    border-radius: 50%;
    border-top-color: var(--secondary-color);
    animation: spin 1s ease-in-out infinite;
    margin-bottom: 1rem;
  }
  
  @keyframes spin {
    to {
      transform: rotate(360deg);
    }
  }
  
  .error-message {
    color: var(--error-color);
    text-align: center;
    padding: 2rem;
    background-color: #f8d7da;
    border-radius: 4px;
  }
  
  .no-results {
    text-align: center;
    padding: 2rem;
    color: #666;
  }
  
  .results-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
    gap: 1.5rem;
  }
  
  .app-footer {
    background-color: var(--dark-color);
    color: white;
    text-align: center;
    padding: 1rem;
    font-size: 0.8rem;
  }
  
  @media (max-width: 768px) {
    .app-header h1 {
      font-size: 1.5rem;
    }
    
    .search-box {
      flex-direction: column;
    }
    
    .results-grid {
      grid-template-columns: 1fr;
    }
  }
  </style>