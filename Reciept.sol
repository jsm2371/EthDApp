pragma solidity ^0.5.16;

contract Reciept {
    //스마트컨트랙트에 웹브라우저에 입력한 합계 금액 월, 이름, 영수증 ipfs 해쉬를 스마트 컨트랙트에 영수증이라고 생각하고 작성하고 블록체인에 저장
    mapping(string => reciept) public data; // data라는 변수를 선언하고 ipfs 해쉬 주소값을 string 형으로 키 값으로 정해주고 reciept 구조체에 이름 월 총계를 맵핑
    
    event send_to_database(uint m, string n, uint total); 
    // 추후 데이터 베이스에 스마트 컨트렉트가 deployed 될 때마다 이벤트에서 입력된 값을 전달 하기 위한 event 키워드
    struct reciept{
        uint month;
        string name;
        uint total_money;
    }
    
    string public _ipfs; // ipfs를 기록할 ipfs 변수
    
    function set(string memory address_ipfs) public returns(string memory){
        _ipfs = address_ipfs;
        // ipfs를 set 해줌
    }
    function addreciept(string memory ipfs, uint _month, string memory _name, uint _money) public {
        data[ipfs] = reciept(_month, _name, _money); // ipfs 주소로 월, 이름, 총계를 멥핑을 해준다.
        emit send_to_database(_month, _name, _money ); // addreciept 실행 할 때마다 데이터 추가
    }
    
    

    
}