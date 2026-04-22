//
//  ApiClient.swift
//  EnglishCards
//
//  Created by Asael Rodriguez on 20/04/26.
//

import Foundation

class ApiClient {
    
    
    /// T: Decodable → Puede regresar cualquier modelo que sea Decodable
    ///     •    async → Es asíncrona (usa await)
    ///     •    throws → Puede lanzar errores
    ///     •    -> T → Regresa el modelo decodificado
    func request<T: Decodable>(url: URL) async throws -> T {
        /// Hace request a la URL
        /// •    await espera respuesta
        /// •    data contiene el JSON
        let (data, _) = try await URLSession.shared.data(from: url)
        
        /// Convierte data (JSON)
        /// •    A tu modelo (Phrase, User, etc.)
        /// •    Regresa ese objeto
        return try JSONDecoder().decode(T.self, from: data)
    }
}

/*
    let phrases: [Phrase] = try await apiClient.request(url: url)
 */
