import os



def get_satellite_catalog(catalog:str) -> dict:
    """
    This function reads all the satellite NORAD CAT ID
    Args:
        catalog (str): The path to the catalog file

    Returns:
        sate_code_name: A dict with satellite name as the key
        and satellite NORAD CAT ID as value
    """    
    sate_code_name = {}
    with open(catalog,'r') as f:
        line_list = f.readlines()
    for i,item in enumerate(line_list):
        if i%3 == 0:
            sate_name = item[2:-2]
        elif i%3 == 1:
            sate_code = item[2:8]
            sate_code_name[sate_name] = sate_code
    return sate_code_name

catalog = os.path.abspath('data/catalog.txt')
sate_code_name = get_satellite_catalog(catalog=catalog)