import XCTest
@testable import Pago

final class PagoTests: XCTestCase {

    func testExtractContactInitialsForContactViewThumbnail(){
        let mockName1 = "Mihai Rusu"
        let mockName2 = "Dr. Mihai Rusu"
        
        let st1 = ExtractContactInitials(name:mockName1).initials(mockName1)
        let st2 = ExtractContactInitials(name:mockName2).initials(mockName2)
         XCTAssertEqual(st2, st1)
    }
    
    func testExtractContactInitialsForContactMoreThan2Names(){
        let mockName1 = "Viorel Mihai Rusu"
       
        let st1 = ExtractContactInitials(name:mockName1).initials(mockName1)
        let st2 = "VM"
        XCTAssertEqual(st2, st1)
    }

}
