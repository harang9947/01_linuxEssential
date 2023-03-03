Linux 기초 관리자 과정

##########################
제 1장 리눅스 소개
##########################

리눅스 배포판의 계열에 따라 관리방법이 조금씩 다름

자격증 종류
* 민간 자격증 (국가 인정x)

* 국가 자격증 (국가 인정o)
	리눅스 마스터 1급/2급
	네트워크 관리사
	정보처리기사

* 국제 공인 자격증 (국가 인정x 유사자격증이 없는경우 인정해주는경우도 있음)
	AWS SA
	RedHat RHCSA/RHCE
	LPIC

복제된 운영체제에서 변경사항

터미널에서 tap 키를 눌리면 자동완성 기능이 있음

호스트이름
	hostnamectl  호스트이름 확인
	hostnamectl set-hostname sever1.example.com 호스트 이름변경

ip설정
	nm-connection-editor ip설정변경
	nmcli connection up ens33(이더넷 이름) 활성화


리눅스와 윈도우사이에서 글자 붙여넣기 shift + insert

##########################
제 2장 리눅스 설치
##########################

내용무

##########################
제 3장 리눅스 환경설정
##########################

리눅스의 선수지식  (   | 는  or라는 뜻으로 사용)
* Runlevel == Target
	runlevel 3 == multi-user.target
	runlevel5 == graphical.target

	#systemctil isolate mulit-user.target | graphical.target
	#systemctl set-default multi-user.target | graphical.target

서비스 기동
	#systemctl enable | disable firewalld
	#systemctl start | stop firewalld

제어 문자 control character
	<CTRL + C> 인터럽트하여 강제종료   
	<CTRL + D> 파일의 끝, 쉘 종료

운영체제 셧다운과 재부팅
전원끄기 init 0 , poweroff ...
재부팅 init 6 , reboot ...
(0과 6의 의미 = runlevel)
Runlevel 0 = power off
Runlevel 6 = reboot

도움말과 암호변경
	man CMD
		# man ls (메뉴얼 오픈)
		# man -k calendar  (완성된 영문단어) 해당 단어 관련 매뉴얼 오픈
		# man -f passwd     passwd 매뉴얼 오픈
		# man -s 5 passwd  5번섹션의 passwd 파일 매뉴얼 오픈

매뉴얼 섹션
- Section 1 : 명령어 및 데몬등에 대한 매뉴얼
- Section 5 : 운영체제 설정 파일 및 데몬의 설정 파일 매뉴얼

	passwd CMD
		#passwd fedora (fedora계정의 비밀번호 변경)



##########################
제 4장 리눅스 기본정보확인
##########################

시스템 기본 정보 확인

	uname CMD
		# uname -a 운영체제 커널버전이라 cpu 종류 알아볼때 사용
		#cat /etc/redhat-release 운영체제 배포판버전 알아볼때 사용

		[참고] redhat documentation
		access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8
	date CMD
		# date 08301300(날짜와 시간 확인 및 변경)
		# date +%m%d (순서변경하여 나타낼수있음)

		[실무예] NTP 서버에 시간 동기화
		# vi /etc/chrony.conf
		server time.bora.net iburst
		# systemctl stop chronyd
		# systemctl start chronyd

	cal CMD 
	# cal (달력출력) 

##########################
제 5장 파일 및 디렉토리 관리
##########################

디렉토리 이동 관련 명령어
	[참고] 파일시스템 기본 구조
	#man 7 hier (파일시스템 기본구조 매뉴얼 페이지 확인방법)

	pwd CMD
	[참고] PS1 변수 ($HOME/ .bashrc 파일에 넣으면 지속력을 가짐)
	# export PS1='[\u@\h \w]\$ '

	cd CMD
		경로
		*상대경로 # cd dirl
		*절대경로 # cd /dirl

	[참고] 자신의 홈디렉토리 이동 
		# cd
		# cd ~
		# cd $HOME
	[참고] 사용자 홈디렉토리 이동
		# cd ~fedora

	[실무예] 이전 디렉토리로 이동
		#cd -

	[실무예] 옆에 있는 디렉토리로 이동하기
		#cd ../dir2


디렉토리 관리 명령어

	ls CMD
		# ls -l dir1 (하위 디렉토리 정보출력)
		# ls -ld dir1(현재 디렉토리 정보 출력)
		OPTIONS : -l, -d, -R , -a, -F , -i , -h ,-r , -t

		[참고] alias (직접 명령어를 단축시켜 사용할수 있도록 만들수 있음)
			(예로 ls -l이라는 명령어를 ll로 줄여 만들수있다.)
		(선언) # alias ls='ls -l | grep "^-"'
		(확인) # alias
		(해제) # unalias ls

		[실무예] 실무에서 많이 사용되는 ls CMD
		# cd /Log_dir
		# ls -altr (가장 밑에 나타나는것이 가장 최근의 로그파일이다.)

	mkdir CMD
		# mkdir -p dir1/dir2  (-p는 있으면 만들지않고 없으면 만든다)

	rmdir CMD
		#rm -rf dir1 (-r은 모든내용을 지우고 f는 삭제여부를 묻지않게된다.)
		(주의) 항상 파일/디렉토리 삭제시 주의해야하며 다시 생각해봐야한다.

파일 관리 명령어

	touch CMD
		# touch -t 08301300 file1 (file1의 생서시간을 08301300으로 변경)
	cp CMD
		# cp file1 file2
		# cp file1 dir1
		# cp -r dir1 dir2(폴더가 이미 있는경우 안에 복사가됨)
		OPTIONS : -r, -i, -f, -p, -a

		[실무예] 
		# cp -p httpd.conf httpd.conf.orig
		파일을 백업할때 -p을 이용하여 백업을 진행한다 -p를 이용하지
		않고 백업시 속성값이 달라진다. 
		# cp -a /src /src.orig

		[실무예]
		# cp /dev/null file.log
		# cat /de/null > file.log
		# > file.log
		
	mv CMD
		# mv file1 file2 (이름 변경)		
		# mv file1 dir1 (이동)
		# mv dir1 dir2 (\dir2가 있으면 dir1이 2로 이동 없다면 1의 이름이 
			2로변경됨)
		
		[참고] 와일드 캐릭터(wild charactor)
		*  ?  []  {}
	
	rm CMD
		# rm -rf dir1

		[실무예] rm  명령어로 지운 파일 복원하기
		{TUI} extundelete CMD
		{GUI) TestDisk 툴

		


파일 내용 확인 명령어

	cat CMD
		# cat -n file1 (1의 내용에 줄번호 나타냄)
		# cat file1 file2 > file3 (1과2의 내용을 3에 합친다.)

	more CMD
		# CMD | more
		# ps -ef | more
		# cat /etc/services | more
		# netstat -an | more
		# systemctl list-unit-files

	
	head CMD
		[실무예] pps/nstat 엘리어스 만들기
		# alias ps-'ps -ef' | head -1 ; ps -ef | grep $1'
		# alias nstate='netstat -antup | head -2 ; netstat -antup | grep $1'

	tail CMD
		# top
		# tail -f /var/log/messages
		
		# tail -f /var/log/messages | egrep -i 'warn|error|fail|crit|alert|emerg'
		# tail -f /varlog/messages /var/log/secure
		
		[참고] telnet 서비스 기동하기
		# yum install tenlet telnet-server (텔넷 패키지 설치)
		# systemctl enable --now telnet.socket(--now를 사용하면 현재와 다음에도 동시에 기동하게됨 --now를 안쓰면 #systemctl start) telnet.socket을 작성한번더 하면된다.



기타 관리용 명령어

	wc CMD
		[참고] 데이터 수집(Data Gathering)
		# ps -ef | tail -n +2 | wc -1
		# cat /etc/passwd | wc -1
		# rpm -qa | wc -1
		# df -k / taill -1 | awk '{pring $5}'
		# cat /var/log/messages | grep 'Jun 19' | grep 'Started Telnet Server' | wc -1

	su CMD
		# su oracle
		#su - oracle

	sudo CMD(/etc/sudoers, /etc/sudoers.d/*)
		# sudo CMD
		# sudo -l (목록확인)
		# sudo -i (관리자로 변경)

	id CMD
		
	groups CMD


	last CMD (/var/log/wtmp) (파일이름)
		# last -i
		# last -f /var/log/wtmp.20230128
		lastlog(/var/log/lastlog) (서버에 사용자가 마지막으로 로그를 남긴것을 볼수있음)


	lastb CMD (/var/log/btmp) (파일이름)
		
	who CMD (/var/run/utmp)

	w CMD
		while true(모니털링할때 사용)
		do
			echo "===`date`---"
			CMD
			sleep 2
		done

		[참고] watch CMD (모니터링할때 사용)

################
제 06장 파일 종류
################

일반 파일(Regular File)

디렉토리 파일(Directory File)

링크파일 (Link File)
	하드 링크 파일(Hard link File)
	# ln file1 file2 (1은 존재해야되고 2는 존재하면 안됨)
	심볼릭(소프트) 링크 파일 (Symbolic Link File)
	# in -s file1 file2 (1은 존재해야되고 2는 존재하면 안됨)

장치파일 (Device)
	블록 장치 파일 (Block Device File)
	캐릭터 장치 파일 (Character Device File)

#######################
제 07장 파일 속성 관리
#######################

	chown CMD
		# chown -R fedora:fedora /home/fedora
	
	chgrp CMD


	chmod CMD
		퍼미션 변경
			심볼릭 모드(symbolic Mode) # chmod u+x file1
			옥탈 모드(Octal Mode) # chmod 755 file1
	파일 & 디렉토리 퍼미션 의미
	파일 (r / w / x)
	디렉토리( r(ls -l CMD)  / w(생성/삭제) / x( cd CMD)
	
	퍼미션 적용순서
	UTD check -> GIDs check -> other
	umask CMD( 002 -> 022 -> 027)
	(관리자) /etc/bashrc
	(사용자) $HOME/ .bashrc

MAC
IP address? 호스트 구분하는 번호
Port address? 서비스 구분하는 번호
0~ 65535
0~1023 : 잘 알려진 서비스를 위해 할당하는 포트 번호
	22: SSH
	23:Telnet
	25:SMTP
	53: DNS
	80: HTTP
	110: POP3
	143:IMAP4
	123: NTP

#####################
제 08장 VI/VIM 편집기
#####################

VI 편집기 모드
명령모드(command/edit mode)
입력모드(Insert/Input Mode)
최하위행 모드(Last Line Mode/Ex Mode)

VI 편집기 환경파일
 $HOME/.vimrc
	set nu
	set ai
	set ts=4

##################################
제 09장 사용자와 통신할 때 사용하는 명령어
##################################

mail/mailx CMD
	#mailx -s '[제목] server1' admin@example.com < /root/report.txt
wall CMD
	wall < /etc/MESS/work.txt

	[참고] 긴급 작업 절차
	# touch /etc/nologin (새로운 사용자 접속 제한)
	wall < /etc?MESS/work.txt
	...
	#fuser -cu /home (사용자 확인)
	#fuser -ck /home (사용자 강제방출)
	작업진행
	# rm -f /etc/nologin

###############################
제 10장 관리자가 알아두면 유용한 명령어
###############################

cmp/diff CMD
	[실무예] 설정 파일 비교
	# diff httpd.conf httpd.conf.OLD

	[실무예] 디렉토리 마이그레이션 종료 후 비교
	# diff -r /was1 /was1 /was2

sort CMD
	# CMD | sort -k 3
	# CMD | sort -k 3 -r

file CMD




################################################################
