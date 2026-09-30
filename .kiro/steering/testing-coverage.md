---
inclusion: fileMatch
fileMatchPattern: '**/*.{py,java,js,jsx,ts,tsx,html,css,scss,ipynb,json},.kiro/specs/**/*'
---

# Estándar de cobertura de pruebas

Cobertura **mínima** por capa:

- **Dominio**: > 90%.
- **Casos de uso**: >= 85%.
- **Adaptadores**: >= 70%.
- **Global**: >= 80%.

Estos son mínimos. Lo recomendable es mantener todas las capas por encima del **90%**.

## Reglas

- Prioriza pruebas de la lógica de negocio (dominio y casos de uso).
- La cobertura es un piso, no una meta: cubre casos límite y rutas de error, no solo la ruta feliz.
- No se integra código que baje la cobertura por debajo del mínimo de su capa.
