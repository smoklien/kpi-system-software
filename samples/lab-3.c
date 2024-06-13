int x = 2;
int z = 0;

void process_function()
{
    if (x > -1)
    {
        z = (x * x * x + 2 * x * x + 11) / (2 * x + 1);
    }
}

int main()
{
    process_function();
    
    return 0;
}