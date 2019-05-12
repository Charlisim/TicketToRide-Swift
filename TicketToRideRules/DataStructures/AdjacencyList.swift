/// Copyright (c) 2019 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

public struct AdjacencyList: Graph {
  public typealias Edge = Line
  public typealias Vertex = Station

  private var adjacencies: [ Vertex: [Edge] ] = [:]

  public var vertices: [Vertex] {
    return Array(adjacencies.keys)
  }

    @discardableResult mutating public func addVertex(_ element: Vertex) -> Vertex {
    let vertex = Station(index: vertices.count, element: element.name)
    adjacencies[vertex] = []
    return vertex
  }

  mutating func add(_ edge: Edge) {
    adjacencies[edge.start]?.append(edge)
    
    let reversedEdge = Line(start: edge.destination, end: edge.start, cost: edge.cost)
    adjacencies[edge.destination]!.append(reversedEdge)
  }
  
    public func getEdges(from source: Vertex) -> [Edge] {
    return adjacencies[source] ?? []
  }
}

extension AdjacencyList: CustomStringConvertible {
    public var description: String {
    return
      adjacencies.mapValues { edges in
        edges
          .sorted { $0.destination.index < $1.destination.index }
          .map { "\($0.destination.name) (\($0.weight))" }
      }
      .sorted { $0.key.index < $1.key.index }
      .map {
        let source = "\($0.key.index): \($0.key.name)"

        guard !$0.value.isEmpty else {
          return source
        }

        let sourceWithArrow = "\(source) -> "
        return """
          \(sourceWithArrow)\($0.value.joined(separator: "\n"
            + String(repeating: " ", count: sourceWithArrow.count)
          ))
          """
      }
      .joined(separator: "\n\n")
  }
}
