using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SharkMovementController : MonoBehaviour
{
    public float speed = 1.0f;

    // Start is called before the first frame update
    void Start()
    {
        
    }
    // Update is called once per frame
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.W))
        {
            gameObject.transform.Translate(Vector3.forward * speed, Space.World);
        }
        if (Input.GetKeyDown(KeyCode.A))
        {
            gameObject.transform.Translate(Vector3.left * speed, Space.World);
        }
        if (Input.GetKeyDown(KeyCode.S))
        {
            gameObject.transform.Translate(Vector3.back * speed, Space.World);
        }
        if (Input.GetKeyDown(KeyCode.D))
        {
            gameObject.transform.Translate(Vector3.right * speed, Space.World);
        }
    }
}
