
#include <string>
#include <iostream>

#include "login.h"

using namespace std;

int main()
{
	Login* login1 = new Login();

	string username("markus22");
	string password("flyingtiger45");

	if (login1->authenticate_login_information("markus22", "flyingtiger45") == true)
	{
		cout << "\n\n\nAccount " << username << " has logged on!\n\n\n";
	}
	
	return 1;
}