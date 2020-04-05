import mysql.connector
import numpy

from numpy import dot
from numpy.linalg import norm

def get_user_similarity(matrix, index):
    user_dim = len(matrix)
    user_similarity = numpy.zeros(user_dim)

    for i in range(0, user_dim):
        if norm(matrix[i]) != 0 and norm(matrix[index]) != 0:
            user_similarity[i] = dot(matrix[i], matrix[index])/(norm(matrix[i])*norm(matrix[index]))

    return user_similarity


def get_weighted_sum_uservector(user_post_matrix, similarity_vector, index):
    user_dim = len(user_post_matrix)
    post_dim = len(user_post_matrix[0])

    weighted_vector = numpy.zeros(post_dim)

    for i in range(0, user_dim):
        #import ipdb; ipdb.set_trace() 
        if numpy.sum(user_post_matrix[i]):
            weighted_vector += user_post_matrix[i]*(similarity_vector[i]/numpy.sum(user_post_matrix[i])) 

    return weighted_vector


def fetch_data(database_name):
    cnx = mysql.connector.connect(user='root', password='', host='127.0.0.1', database= database_name)

    mycursor = cnx.cursor()

    mycursor.execute("select max(id) from users")
    user_dim = mycursor.fetchall()[0]

    mycursor.execute("select max(id) from posts")
    post_dim = mycursor.fetchall()[0]

    # import ipdb; ipdb.set_trace()

    user_post_matrix = numpy.zeros((user_dim[0], post_dim[0]))

    mycursor.execute("select * from counters")
    user_post_all = mycursor.fetchall()

    for user_post in user_post_all:
        user_id = user_post[1]
        post_id = user_post[2]
        count = user_post[5]
        user_post_matrix[user_id - 1][post_id - 1] = count




    return user_post_matrix 

def get_recommendation(database_name, user_id):
    user_post_matrix = fetch_data(database_name)
    similarity_vector = get_user_similarity(user_post_matrix, user_id)
    weighted_vector = get_weighted_sum_uservector(user_post_matrix, similarity_vector, user_id)
    sorted_index = numpy.argsort(weighted_vector)[::-1]
    return sorted_index

def main():
    sorted_index = get_recommendation("football_news_development", 0)
    print(sorted_index)

if __name__ == "__main__":
    main()

