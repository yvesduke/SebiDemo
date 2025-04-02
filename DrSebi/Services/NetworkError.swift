enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(Int)
    case unknown(Error)
    case unknownMessage(String)
    
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data received"
        case .decodingError:
            return "Failed to decode response"
        case .serverError(let code):
            return "Server error with status code: \(code)"
        case .unknown(let error):
            return error.localizedDescription
        case .unknownMessage(let message):
            return message
        }
    }
} 
