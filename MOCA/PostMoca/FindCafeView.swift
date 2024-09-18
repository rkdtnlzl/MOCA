//
//  FindCafeView.swift
//  MOCA
//
//  Created by 강석호 on 9/18/24.
//

import SwiftUI

struct FindCafeView: View {
    @Binding var showModal: Bool
    @Binding var text: String
    @Binding var showText: Bool
    
    @State private var cafes: [Cafe] = []
    @State private var inputText: String = ""
    
    var body: some View {
        VStack {
            TextField("카페를 검색하세요", text: $inputText, onCommit: {
                fetchCafes(keyword: inputText)
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            
            List(cafes) { cafe in
                Button(action: {
                    text = cafe.placeName
                    showText = true
                    showModal = false
                }) {
                    VStack(alignment: .leading) {
                        Text(cafe.placeName)
                            .font(.headline)
                            .foregroundColor(.black)
                        Text(cafe.addressName)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .background(Color.white)
        }
    }
    
    func fetchCafes(keyword: String) {
        let apiKey = APIKey.kakaoKey
        let urlString = "https://dapi.kakao.com/v2/local/search/keyword.json?query=\(keyword)&category_group_code=CE7"
        guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else {
            print("잘못된 URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("KakaoAK \(apiKey)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print("에러 발생: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("데이터 없음")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(CafeResponse.self, from: data)
                DispatchQueue.main.async {
                    self.cafes = response.documents
                }
            } catch {
                print("디코딩 에러: \(error.localizedDescription)")
            }
        }.resume()
    }
}

#Preview {
    FindCafeView(showModal: .constant(false), text: .constant(""), showText: .constant(false))
}
